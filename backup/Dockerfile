FROM ubuntu:16.04

WORKDIR /root

RUN mkdir /containers

RUN DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  cron \
  curl \
  supervisor \
  build-essential \
  unzip \
  mongodb-org-tools

ADD backup.sh /usr/bin/backup.sh
ADD startup.sh /usr/bin/startup.sh
ADD crontab /etc/crontab
ADD supervisor.conf /etc/supervisor/conf.d/backup.conf

WORKDIR /usr/local/src
RUN curl -O https://downloads.rclone.org/rclone-v1.36-linux-amd64.zip
RUN unzip rclone-v1.36-linux-amd64.zip
WORKDIR /usr/local/src/rclone-v1.36-linux-amd64
RUN cp rclone /usr/bin/
RUN chmod +x /usr/bin/rclone
VOLUME /root/.config/rclone

VOLUME "/backups"

CMD ["/usr/bin/startup.sh"]
