#!/bin/bash

RUBYGEMS_VERSION=1.7.2

INITIAL_DIR=`pwd`
cd `dirname $0`
CHEF_REPO_ROOT=`pwd`
cd $INITIAL_DIR

echo "Updating apt package index..."
sudo yum --yes update

echo "Installing chef's required apt packages..."
sudo yum --yes install ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert

echo "Installing rubygems $RUBYGEMS_VERSION from source..."
cd /tmp
wget http://production.cf.rubygems.org/rubygems/rubygems-$RUBYGEMS_VERSION.tgz
tar zxf rubygems-$RUBYGEMS_VERSION.tgz
cd rubygems-$RUBYGEMS_VERSION
sudo ruby setup.rb --no-format-executable

echo "Installing chef..."
sudo gem install chef --no-rdoc --no-ri

echo "Setting up chef-solo..."
sudo env SSL_CRT=$SSL_CRT SSL_KEY=$SSL_KEY FQDN=$FQDN ruby $CHEF_REPO_ROOT/setup/setup-chef-solo-config.rb
