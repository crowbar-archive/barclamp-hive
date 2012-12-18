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

hive_packages=%w{
  hive
  hive-metastore
  hive-server
  hive-server2
}

hive_packages.each do |pkg|
  package pkg do
    action :install
  end
end

service "hive-server" do
  supports :start => true, :stop => true, :status => true, :restart => true
  action :enable
end

# Setup the hive config file.
template "/etc/hive/conf/hive-site.xml" do
  owner node[:hive][:process_file_system_owner]
  group node[:hive][:global_file_system_group]
  mode "0644"
  source "hive-site.xml.erb"
  notifies :restart, resources(:service => "hive-server")
end

service "hive-server" do
  action  :start
end

#######################################################################
# End of recipe
#######################################################################
Chef::Log.info("END hive") if debug
