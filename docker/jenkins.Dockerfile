# FROM jenkins/jenkins:lts-alpine-jdk21
# RUN jenkins-plugin-cli --plugins "blueocean docker-plugin docker-workflow"

# DOCKER-IN-DOCKER
FROM docker:dind AS docker
ENV DOCKER_TLS_CERTDIR=/certs
RUN  mkdir -p /home/jenkins/cloud_agents /home/jenkins/agent1 /home/jenkins/agent2
VOLUME [ "/certs/client", "/home/jenkins" ]


# JENKINS SERVER
FROM jenkins/jenkins:lts-alpine-jdk21 AS server
RUN jenkins-plugin-cli --plugins "blueocean docker-plugin docker-workflow ssh-agent"
VOLUME [ "/var/jenkins_home" ]


# JENKINS AGENT
FROM jenkins/ssh-agent:debian-jdk21 AS agent
RUN apt-get update && apt-get install -y curl && apt-get clean
ENV DOCKER_HOST=tcp://docker:2376 DOCKER_CERT_PATH=/certs/client DOCKER_TLS_VERIFY=1

# Install Docker client
ARG DOCKER_VERSION=27.3.1
ARG DOCKER_COMPOSE_VERSION=2.29.7
ARG DOCKER_BUILDX_VERSION=0.17.1
RUN curl -fsSL https://download.docker.com/linux/static/stable/`uname -m`/docker-$DOCKER_VERSION.tgz | tar --strip-components=1 -xz -C /usr/local/bin docker/docker
RUN curl -fsSL https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# Enable buildx plugin
## buildx is released as amd64, and uname calls it x86_64
RUN uname -m > /tmp/arch \
    && sed -i 's/x86_64/amd64/g' /tmp/arch \
    && mkdir -p /usr/libexec/docker/cli-plugins/  \
    && curl -fsSL https://github.com/docker/buildx/releases/download/v$DOCKER_BUILDX_VERSION/buildx-v$DOCKER_BUILDX_VERSION.linux-`cat /tmp/arch` > /usr/libexec/docker/cli-plugins/docker-buildx  \
    && chmod +x /usr/libexec/docker/cli-plugins/docker-buildx \
    && docker buildx install \
    && rm /tmp/arch
