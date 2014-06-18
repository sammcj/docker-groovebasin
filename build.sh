#!/usr/bin/env bash
set -e


su -c 'git clone https://github.com/andrewrk/groovebasin.git /home/groovebasin/groovebasin-build' \
    -s /bin/bash groovebasin

# Every once in a while npm fails because some server
# returns a bad package. Trying this twice seems to
# get everything in, though
su -c 'cd /home/groovebasin/groovebasin-build && npm install' -s /bin/bash groovebasin || true
su -c 'cd /home/groovebasin/groovebasin-build && npm install && ./build' -s /bin/bash groovebasin

apt-get -y remove libgroove-dev libgrooveplayer-dev \
libgrooveloudness-dev libgroovefingerprinter-dev \
manpages manpages-dev g++ gcc cpp make ucf \
python-software-properties unattended-upgrades \
g++ gcc cpp build-essential git python

apt-get -y autoremove
