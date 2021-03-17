#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER caluma WITH PASSWORD '$CALUMA_DB_PASSWORD';
    CREATE DATABASE caluma OWNER caluma;
    GRANT CONNECT ON DATABASE caluma TO caluma;
    ALTER USER caluma CREATEDB;
    CREATE USER keycloak WITH PASSWORD '$KEYCLOAK_DB_PASSWORD';
    CREATE DATABASE keycloak OWNER keycloak;
    GRANT CONNECT ON DATABASE keycloak TO keycloak;
    CREATE USER dms WITH PASSWORD '$DMS_DB_PASSWORD';
    CREATE DATABASE dms OWNER dms;
    GRANT CONNECT ON DATABASE dms TO dms;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d caluma <<-EOSQL
    CREATE EXTENSION hstore;
EOSQL
