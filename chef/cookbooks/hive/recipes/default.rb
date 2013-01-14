#
# Cookbook Name: hive
# Recipe: default.rb
#
# Copyright (c) 2011 Dell Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#######################################################################
# Begin recipe
#######################################################################
debug = node[:hive][:debug]
Chef::Log.info("BEGIN hive") if debug

# Install the hive packages.
hive_packages=%w{
  hive
  hive-metastore
  hive-server2
}

hive_packages.each do |pkg|
  package pkg do
    action :install
  end
end

if node[:hive][:hive_metastore_mode] == "local" || node[:hive][:hive_metastore_mode] == "remote"
  package "mysql-server" do
    action :install
  end
  
  cookbook_file "/usr/lib/hive/lib/mysql-connector-java-5.1.22-bin.jar" do
    source "mysql-connector-java-5.1.22-bin.jar"
    owner "root"
    group "root"
    mode "0644"
  end
  
  service "mysqld" do
    supports :start => true, :stop => true, :status => true, :restart => true
    action :enable
  end
  
  service "mysqld" do
    action  :start
  end
end

# Define the hive server process.
service "hive-server2" do
  supports :start => true, :stop => true, :status => true, :restart => true
  action :enable
end

# Setup the hive configuration file.
template "/etc/hive/conf/hive-site.xml" do
  source "hive-site.xml.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "hive-server2")
end

# Start the hive server.
service "hive-server2" do
  action  :start
end

#######################################################################
# End of recipe
#######################################################################
Chef::Log.info("END hive") if debug
