# Cookbook Name:: marklogic
# Recipe:: default

yum_package "glibc" do
   arch "i686"
end
package "redhat-lsb"
package "sysstat"
package "psutils"

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

cookbook_file "/usr/local/bin/booster.py" do
  source "booster.py"
  mode "0755"
  owner "root"
  group "root"
end

python "configure mark logic" do
  user "root"
  cwd "/tmp"
  environment ({"PYTHONPATH" => '/usr/local/bin'})

  code <<-EOH
import booster

server_name = "http://localhost:8001"
booster.configureAuthHttpProcess(server_name, "admin", "admin")
booster.license(server_name)
booster.agree_go(server_name)
#booster.initialize_go(server_name)
  EOH
end

execute "/etc/init.d/MarkLogic restart" do
  action :run
end

python "configure mark logic" do
  user "root"
  cwd "/tmp"
  environment ({"PYTHONPATH" => '/usr/local/bin'})

  code <<-EOH
import booster

server_name = "http://localhost:8001"
booster.configureAuthHttpProcess(server_name, "admin", "admin")
booster.security_install_go(server_name)
booster.test_admin_connection(server_name)
  EOH
end
