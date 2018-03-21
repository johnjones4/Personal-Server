#!/bin/bash

TIMESTAMP=$(date "+%Y_%m_%d")
BACKUP_DIR="/backups"

ROLODEX_FILES="$BACKUP_DIR/rolodex_$TIMESTAMP"
tar zcf "$ROLODEX_FILES.tar.gz" "/containers/rolodex"

DOOMSDAY_MACHINE_FILES="$BACKUP_DIR/doomsday_machine_config_$TIMESTAMP"
tar zcf "$DOOMSDAY_MACHINE_FILES.tar.gz" "/containers/doomsday-machine"

PLEX_FILES="$BACKUP_DIR/plex_$TIMESTAMP"
tar zcf "$PLEX_FILES.tar.gz" "/containers/plex"

find "$BACKUP_DIR" -type f -mtime +7 -delete

/usr/bin/rclone sync "$BACKUP_DIR" Dropbox:/John/SERVER_2 
