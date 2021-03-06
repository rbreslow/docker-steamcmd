# docker-steamcmd [![CI](https://github.com/rbreslow/docker-steamcmd/workflows/CI/badge.svg?branch=master)](https://github.com/rbreslow/docker-steamcmd/actions?query=workflow%3ACI) [![Docker Repository on Quay](https://quay.io/repository/rbreslow/steamcmd/status "Docker Repository on Quay")](https://quay.io/repository/rbreslow/steamcmd)

This repository contains a `Dockerfile` designed to support installing and updating various dedicated servers available on Steam using [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD).

## Usage

First, build the container image with:

```bash
docker build -t quay.io/rbreslow/steamcmd:slim .
```

Then, create an instance of the container image:

```bash
$ docker run --rm -ti --volume /tmp/css_ds:/var/lib/steam/css_ds quay.io/rbreslow/steamcmd:slim
...
Steam Console Client (c) Valve Corporation
-- type 'quit' to exit --
Loading Steam API...OK.

Steam>
```

Login anonymously and download Counter-Strike: Source DS:

```bash
Steam>login anonymous

Connecting anonymously to Steam Public...Logged in OK
Waiting for user info...OK

Steam>force_install_dir /var/lib/steam/css_ds

Steam>app_update 232330
...
Success! App '232330' fully installed.
```

Detach from the container and test:

```
$ ls /tmp/css_ds
bin                        srcds_linux
cstrike                    srcds_run
hl2                        steamapps
platform                   thirdpartylegalnotices.txt
```

## Testing

An example of how to use `cibuild` to build and test an image:

```bash
CI=1 ./scripts/cibuild
```
