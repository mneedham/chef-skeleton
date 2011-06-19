#
# Cookbook Name:: marklogic
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_package "glibc" do
   arch "i686"
end
package "redhat-lsb"

remote_file "/tmp/marklogic.rpm" do
  source "http://developer.marklogic.com/download/binaries/4.2/MarkLogic-4.2-4.x86_64.rpm"
  mode "0644"
  action :create_if_missing
end

package "MarkLogic" do
  action :install
  source "/tmp/marklogic.rpm"
  provider Chef::Provider::Package::Rpm
end

execute "/etc/init.d/MarkLogic start" do
  action :run
  creates "/var/run/MarkLogic.pid"
end

cookbook_file "/opt/MarkLogic/Admin/booster.xqy" do 
  source "booster-0.2b.xqy"
  mode "0755"
  owner "root"
  group "root"
end
