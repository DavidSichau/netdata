#!/bin/bash
set -e

# install dependencies for build

yum -y install zlib-devel gcc make git autoconf autogen automake pkg-config docker



# fetch netdata

git clone https://github.com/firehol/netdata.git /netdata.git --depth=1
cd /netdata.git

# use the provided installer

./netdata-installer.sh --dont-wait --dont-start-it

# remove build dependencies

cd /
rm -rf /netdata.git

yum remove -y zlib-devel gcc make git autoconf autogen automake pkg-config wget
yum autoremove
rm -rf /tmp/* /var/tmp/*


# symlink access log and error log to stdout/stderr

ln -sf /dev/stdout /var/log/netdata/access.log
ln -sf /dev/stdout /var/log/netdata/debug.log
ln -sf /dev/stderr /var/log/netdata/error.log
