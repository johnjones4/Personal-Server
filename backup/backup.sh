#!/bin/bash

TIMESTAMP=$(date "+%Y_%m_%d")
BACKUP_DIR="/backups"

ROLODEX_FILES="$BACKUP_DIR/rolodex_$TIMESTAMP"
tar zcf "$ROLODEX_FILES.tar.gz" "/containers/rolodex"

DOOMSDAY_MACHINE_FILES="$BACKUP_DIR/doomsday_machine_config_$TIMESTAMP"
tar zcf "$DOOMSDAY_MACHINE_FILES.tar.gz" "/containers/doomsday-machine"

PLEX_FILES="$BACKUP_DIR/plex_$TIMESTAMP"
tar zcf "$PLEX_FILES.tar.gz" "/containers/plex"

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
