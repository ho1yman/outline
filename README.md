# outline
outline知识库部署

1. 创建compose项目路径

   ```sql
   mkdir /opt/compose/outline
   cd /opt/compose/outline
   ```
2. 拉取容器镜像

   ```sql
   docker pull keycloak/keycloak:26.1.2
   docker pull postgres:15-alpine
   docker pull redis:7-alpine
   docker pull minio/minio:latest
   docker pull outlinewiki/outline:0.83.0
   ```
3. 创建docker network

   ```sql
   docker network create --driver bridge --subnet 192.168.232.0/24 outline_network
   ```
4. 创建两个secretKey

   ```sql
   # create outline SECRET_KEY
   openssl rand -hex 32
   # create outline UTILS_SECRET
   openssl rand -hex 32
   ```
5. 初始化数据库

   ```sql
   docker-compose -f init_database.yml up -d
   ```

   执行sql

   ```sql
   # create role
   CREATE ROLE "keycloak" SUPERUSER CREATEDB CREATEROLE LOGIN REPLICATION BYPASSRLS PASSWORD 'your_password';
   
   # create db
   CREATE DATABASE "keycloak"
   WITH
     OWNER = "keycloak"
     ENCODING = 'UTF8'
     TABLESPACE = "pg_default";
   ```

   销毁容器

   ```sql
   docker-compose -f init_database.yml down
   ```
6. 运行docker-compose.yml

   ```sql
   docker-compose up -d
   ```
7. 创建minio bucket

   访问minio控制台页面，手动创建outline-bucket
8. 初始化oidc鉴权

   访问keycloak控制台页面，手动创建realm应用、realm客户端，生成密钥并填入到.env的OIDC_CLIENT_SECRET
   重新创建outline容器，登录访问outline

9. 完成！

