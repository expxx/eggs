#FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:11.0.13_8-jdk-focal
FROM ghcr.io/expxx/image:base


RUN   apt update \
      && apt install -y --no-install-recommends openjdk-11-jdk-headless \
      && apt-get clean autoclean \
      && apt-get autoremove --yes \
      && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN   useradd -d /home/container -m container


USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
COPY        ./../utils.sh /utils.sh

RUN         chmod 777 /utils.sh
RUN         chmod 777 /entrypoint.sh

CMD         [ "/bin/bash", "/entrypoint.sh" ]