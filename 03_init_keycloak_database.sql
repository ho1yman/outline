-- Active: 1745161958981@@192.168.63.147@54322@outline
# create role
CREATE ROLE "keycloak" SUPERUSER CREATEDB CREATEROLE LOGIN REPLICATION BYPASSRLS PASSWORD 'your_password';

# create db
CREATE DATABASE "keycloak"
WITH
  OWNER = "keycloak"
  ENCODING = 'UTF8'
  TABLESPACE = "pg_default";
