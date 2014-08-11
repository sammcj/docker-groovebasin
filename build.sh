#!/usr/bin/env bash
set -e

apt-get update 
apt-get install -y software-properties-common
apt-add-repository ppa:andrewrk/libgroove
apt-add-repository ppa:chris-lea/node.js
apt-get update

apt-get -y install build-essential git python
apt-get -y install libgroove-dev libgrooveplayer-dev \
    libgrooveloudness-dev libgroovefingerprinter-dev \
    libgroove4 libgrooveplayer4 libgrooveloudness4 libgroovefingerprinter4
apt-get -y install nodejs

useradd -m groovebasin -G audio 
mkdir /music && touch /music/.dummy 
chown groovebasin:groovebasin /music 
mkdir /groove && touch /groove/.dummy 
chown groovebasin:groovebasin /groove

ln -s /music /home/groovebasin/music
ln -s /groove /home/groovebasin/groovebasin.db
chown groovebasin:groovebasin /home/groovebasin/*

su -c 'git clone https://github.com/andrewrk/groovebasin.git /home/groovebasin/groovebasin-build' \
    -s /bin/bash groovebasin
su -c 'cd /home/groovebasin/groovebasin-build && git checkout tags/1.2.1' \
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
