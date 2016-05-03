#!/bin/bash
set -e

# install dependencies for build

yum -y install zlib-devel gcc make git autoconf autogen automake pkg-config docker which date



# fetch netdata

git clone https://github.com/firehol/netdata.git /netdata.git --depth=1
cd /netdata.git


# use the provided installer

./netdata-installer.sh --dont-wait --dont-start-it
#allow netdata to read docker sock
mkdir -p /var/run/docker.sock
chown netdata:netdata /var/run/docker.sock 
# remove build dependencies

cd /
rm -rf /netdata.git

yum remove -y zlib-devel gcc make git autoconf autogen automake pkg-config wget
yum autoremove -y
rm -rf /tmp/* /var/tmp/*


# symlink access log and error log to stdout/stderr

ln -sf /dev/stdout /var/log/netdata/access.log
ln -sf /dev/stdout /var/log/netdata/debug.log
ln -sf /dev/stderr /var/log/netdata/error.log
