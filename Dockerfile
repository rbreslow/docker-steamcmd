FROM debian:stretch-slim

MAINTAINER Rocky Breslow <breslowrocky@gmail.com>

ENV DEBIAN_FRONTEND "noninteractive"

# `steamcmd` is nonfree
RUN echo "deb http://deb.debian.org/debian stretch non-free" > /etc/apt/sources.list.d/steamcmd.list

# Install `steamcmd` and agree to interactive license
RUN set -ex \
    && deps=" \
       ca-certificates \
       steamcmd \
    " \
     && dpkg --add-architecture i386 \
     && echo steam steam/question select "I AGREE" | debconf-set-selections \
     && apt-get update && apt-get install -y $deps --no-install-recommends \
     && rm -rf /var/lib/apt/lists/*
     
ENTRYPOINT ["/usr/games/steamcmd"]