FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y \
  build-essential \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
RUN apt-get update -y
RUN apt-get install docker-ce -y
USER jenkins
