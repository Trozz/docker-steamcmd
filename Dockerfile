FROM ubuntu:18.04
MAINTAINER Michael Leer <docker@trozzy.net>

# create user for steam
RUN useradd \
      --home-dir /opt/steamcmd \
      --create-home \
      --shell /bin/bash \
      steam \
    && apt-get update \
    && apt-get install -y curl lib32gcc1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && cd /opt/steamcmd \
    && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz \
    && chown -R steam /opt/steamcmd

USER steam
WORKDIR /opt/steamcmd

# Execution vector
ENTRYPOINT ["/opt/steamcmd/steamcmd.sh"]
