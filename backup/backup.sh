#!/bin/bash

TIMESTAMP=$(date "+%Y_%m_%d")
BACKUP_DIR="/backups"

MONGO_FILE="$BACKUP_DIR/mongodb_$TIMESTAMP"
mongodump --host=mongo--port=27017 --out="$MONGO_FILE"
tar zcf "$MONGO_FILE.tar.gz" "$MONGO_FILE"
rm -rf "$MONGO_FILE"

ROLODEX_FILES="$BACKUP_DIR/rolodex_$TIMESTAMP"
tar zcf "$ROLODEX_FILES.tar.gz" "/containers/rolodex"

DOOMSDAY_MACHINE_FILES="$BACKUP_DIR/doomsday_machine_config_$TIMESTAMP"
tar zcf "$DOOMSDAY_MACHINE_FILES.tar.gz" "/containers/doomsday-machine"

PLEX_FILES="$BACKUP_DIR/plex_$TIMESTAMP"
tar zcf "$PLEX_FILES.tar.gz" "/containers/plex"

GITLAB_FILES="$BACKUP_DIR/gitlab_$TIMESTAMP"
tar zcf "$GITLAB_FILES.tar.gz" "/containers/gitlab"

find "$BACKUP_DIR" -type f -mtime +7 -delete

/usr/bin/rclone sync "$BACKUP_DIR" Dropbox:/John/SERVER_2 
