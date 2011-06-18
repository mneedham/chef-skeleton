#!/bin/bash

sudo yum install -y gcc openssl-devel zlib-devel.x86_64
sudo yum groupinstall -y development-tools development-libs

cd /usr/local/src/
sudo curl -O ftp://ftp.ruby-lang.org//pub/ruby/1.9/ruby-1.9.2-p180.tar.gz
sudo tar xvzf ruby-1.9.2-p180.tar.gz
cd ruby-1.9.2-p180
sudo ./configure
sudo make && sudo make install

sudo ln -s /usr/local/bin/ruby /usr/bin/ruby # Create a sym link for the same path 
sudo ln -s /usr/local/bin/gem /usr/bin/gem # Create a sym link for the same path 

cd -

sudo rm /usr/local/src/ruby-1.9.2-p180.tar.gz
sudo rm -rf /usr/local/src/ruby-1.9.2-p180

sudo gem install chef --no-rdoc --no-ri