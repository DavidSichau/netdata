#!/bin/bash
set -e
DEBIAN_FRONTEND=noninteractive

# install dependencies for build

apt-get -qq -y install zlib1g-dev gcc make git autoconf autogen automake pkg-config docker

# fetch netdata

git clone https://github.com/firehol/netdata.git /netdata.git --depth=1
cd /netdata.git

# use the provided installer

./netdata-installer.sh --dont-wait --dont-start-it

# remove build dependencies

cd /
rm -rf /netdata.git

apt-get purge -y zlib1g-dev gcc make git autoconf autogen automake pkg-config
apt-get -y autoremove
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# symlink access log and error log to stdout/stderr

ln -sf /dev/stdout /var/log/netdata/access.log
ln -sf /dev/stdout /var/log/netdata/debug.log
ln -sf /dev/stderr /var/log/netdata/error.log
