FROM ubuntu:18.04

WORKDIR /root

RUN mkdir /containers

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
RUN wget https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key add ACCC4CF8.asc

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  curl \
  unzip \
  postgresql-client-11

ADD backup.sh /usr/bin/backup.sh
ADD loop.sh /usr/bin/loop.sh

WORKDIR /usr/local/src
RUN curl -O https://downloads.rclone.org/v1.42/rclone-v1.42-linux-amd64.zip
RUN unzip rclone-v1.42-linux-amd64.zip
WORKDIR /usr/local/src/rclone-v1.42-linux-amd64
RUN cp rclone /usr/bin/
RUN chmod +x /usr/bin/rclone
VOLUME /root/.config/rclone

VOLUME "/backups"

WORKDIR /root

CMD /usr/bin/loop.sh
