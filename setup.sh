#!/bin/bash

mkdir plex
mkdir plex/config
mkdir plex/transcode
mkdir plex/data
mkdir gitlab
mkdir gitlab/etc
mkdir gitlab/log
mkdir gitlab/opt
mkdir doomsday-machine
mkdir doomsday-machine/config
mkdir doomsday-machine/files
mkdir doomsday-machine/files/workdir
mkdir doomsday-machine/files/archives
docker-compose build
