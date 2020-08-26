FROM debian:buster-slim

LABEL maintainer="Rocky Breslow <breslowrocky@gmail.com>"

RUN \
   adduser --system --disabled-password --home /var/lib/steam --shell /sbin/nologin --disabled-password --group steam

ENV DEBIAN_FRONTEND "noninteractive"

# steamcmd is nonfree
RUN echo "deb http://deb.debian.org/debian buster non-free" > /etc/apt/sources.list.d/steamcmd.list

# Install steamcmd and agree to interactive license
RUN set -ex \
   && deps=" \
   ca-certificates \
   steamcmd \
   " \
   && dpkg --add-architecture i386 \
   && echo steam steam/question select "I AGREE" | debconf-set-selections \
   && apt-get update && apt-get install -y $deps --no-install-recommends \
   && rm -rf /var/lib/apt/lists/*

USER steam
WORKDIR /var/lib/steam

ENTRYPOINT ["/usr/games/steamcmd"]
CMD ["+login", "anonymous"]
