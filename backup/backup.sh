#!/bin/bash

TIMESTAMP=$(date "+%Y_%m_%d")
BACKUP_DIR="/backups"

ROLODEX_FILES="$BACKUP_DIR/rolodex_$TIMESTAMP"
tar zcf "$ROLODEX_FILES.tar.gz" "/containers/rolodex"

PLEX_FILES="$BACKUP_DIR/plex_$TIMESTAMP"
tar zcf "$PLEX_FILES.tar.gz" "/containers/plex"

PORTAINER_FILES="$BACKUP_DIR/portainer_$TIMESTAMP"
tar zcf "$PORTAINER_FILES.tar.gz" "/containers/portainer"

SERVERCONFIG_FILES="$BACKUP_DIR/serverconfig_$TIMESTAMP"
tar zcf "$SERVERCONFIG_FILES.tar.gz" "/containers/serverconfig"

IFS=';' read -ra DBS <<< "$POSTGRES_DBS"
for DB in "${DBS[@]}"; do
  echo $DB
  echo "$POSTGRES_HOST:5432:$DB:$POSTGRES_USER:$POSTGRES_PASSWORD" > ~/.pgpass
  chmod 600 ~/.pgpass
  POSTGRES_FILE="$BACKUP_DIR/postgres_${DB}_${TIMESTAMP}"
  pg_dump -f "$POSTGRES_FILE" -h "$POSTGRES_HOST" -U "$POSTGRES_USER" --no-password "$DB"
done

find "$BACKUP_DIR" -type f -mtime +7 -delete

/usr/bin/rclone sync "$BACKUP_DIR" Dropbox:/John/SERVER_2 
