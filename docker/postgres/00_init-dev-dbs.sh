#!/bin/bash
set -e

# Database user creation
psql -v ON_ERROR_STOP=1 --username $POSTGRES_USER <<-EOSQL
		CREATE USER ${DB_USER} WITH SUPERUSER ENCRYPTED PASSWORD '${DB_USER_PASSWORD}';
		CREATE DATABASE ${DB_USER} OWNER ${DB_USER};
EOSQL

LIST_DBS="SELECT datname FROM pg_database WHERE datistemplate = false;"
>&2 echo -e "Database created:\n$(psql --username $POSTGRES_USER -t -A -c "$LIST_DBS")\n"
