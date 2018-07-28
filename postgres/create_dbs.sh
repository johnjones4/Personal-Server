#!/bin/bash

IFS=';' read -ra DBS <<< "$POSTGRES_DBS"
for DB in "${DBS[@]}"; do
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "CREATE DATABASE $DB;"
done