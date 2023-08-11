FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:11.0.13_8-jdk-focal

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN   apt update \
      && apt install -y --no-install-recommends wget git curl tar zip unzip jq locales figlet ruby
      && apt-get clean autoclean \
      && apt-get autoremove --yes \
      && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN wget https://github.com/busyloop/lolcat/archive/master.zip \
    && unzip master.zip \
    && cd lolcat-master/bin \
    && gem install lolcat \
    && cd ../..

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
COPY        ./../utils.sh /utils.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]