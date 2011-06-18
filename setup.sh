#!/bin/bash

yum install -y gcc openssl-devel zlib-devel.x86_64
yum groupinstall -y development-tools development-libs

cd /usr/local/src/
curl -O ftp://ftp.ruby-lang.org//pub/ruby/1.9/ruby-1.9.2-p180.tar.gz
tar xvzf ruby-1.9.2-p180.tar.gz
cd ruby-1.9.2-p180
./configure
make && make install
ln -s /usr/local/bin/ruby /usr/bin/ruby # Create a sym link for the same path  
ln -s /usr/local/bin/gem /usr/bin/gem # Create a sym link for the same path 

cd -

rm /usr/local/src/ruby-1.9.2-p180.tar.gz
rm -rf /usr/local/src/ruby-1.9.2-p180

gem install chef --no-rdoc --no-ri

ln -s /usr/local/bin/chef-solo /usr/bin/chef-solo