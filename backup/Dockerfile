FROM ubuntu:18.04

WORKDIR /root

RUN mkdir /containers

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  cron \
  curl \
  unzip \
  postgresql-client

ADD backup.sh /usr/bin/backup.sh
ADD backup /etc/cron.d/backup
RUN chmod 0644 /etc/cron.d/backup

WORKDIR /usr/local/src
RUN curl -O https://downloads.rclone.org/v1.42/rclone-v1.42-linux-amd64.zip
RUN unzip rclone-v1.42-linux-amd64.zip
WORKDIR /usr/local/src/rclone-v1.42-linux-amd64
RUN cp rclone /usr/bin/
RUN chmod +x /usr/bin/rclone
VOLUME /root/.config/rclone

VOLUME "/backups"

WORKDIR /root

CMD echo "Start" > /backups/log.txt && cron && tail -f /backups/log.txt
