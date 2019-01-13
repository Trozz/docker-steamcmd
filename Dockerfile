FROM ubuntu:18.04
LABEL maintainer="docker@trozzy.net"

RUN useradd \
      --home-dir /opt/steamcmd \
      --create-home \
      --shell /bin/bash \
      steam \
    && mkdir -p /opt/steamcmd/Steam/steamapps/common/ \
    && apt-get update \
    && apt-get install -y curl lib32gcc1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && cd /opt/steamcmd \
    && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz \
    && chown -R steam /opt/steamcmd

USER steam
WORKDIR /opt/steamcmd
VOLUME ["/opt/steam/Steam/steamapps/common"]
ENTRYPOINT ["/opt/steamcmd/steamcmd.sh"]
