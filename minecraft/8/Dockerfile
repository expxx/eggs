#FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:8u312-b07-jdk-focal
FROM ghcr.io/expxx/image:base


RUN   apt update \
      && apt install -y --no-install-recommends openjdk-8-jdk-headless \
      && apt-get clean autoclean \
      && apt-get autoremove --yes \
      && rm -rf /var/lib/{apt,dpkg,cache,log}/

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
COPY        ./../utils.sh /utils.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]