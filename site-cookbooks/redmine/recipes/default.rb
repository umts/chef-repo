#
# Cookbook Name:: redmine
# Recipe:: default
#
# Copyright 2012, UMass Transit Service <transit-mis@admin.umass.edu>
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
include_recipe "mysql::server"
include_recipe "build-essential"
include_recipe "git"

mysql_packages = case node['platform']
when "centos", "redhat", "suse", "fedora", "scientific", "amazon"
  %w{mysql mysql-devel}
when "ubuntu","debian"
  if debian_before_squeeze? || ubuntu_before_lucid?
    %w{mysql-client libmysqlclient15-dev}
  else
    %w{mysql-client libmysqlclient-dev}
  end
end

mysql_packages.each do |pkg|
  package pkg do
    action :nothing
  end.run_action(:install)
end

chef_gem "mysql"

db = node['redmine']['databases']
rmversion = node['redmine']['revision'].to_i

mysql_connection = { :host => "localhost", :username => 'root', :password => node['mysql']['server_root_password'] }

mysql_database db['database'] do
  connection mysql_connection
  action :create
end

mysql_database_user db['username'] do
  password db['password']
  database_name db['database']
  connection mysql_connection
  action :grant
end

application "redmine" do
  path node['redmine']['path']
  owner node['apache']['user']
  group node['apache']['group']

  repository node['redmine']['repo']
  revision   node['redmine']['revision']

  packages node['redmine']['packages'].values.flatten

  migrate true

  rails do
    gems %w{ bundler }
    bundler_without_groups %w{ postgresql sqlite3 }
    bundler_deployment false
    database do
      adapter  db['adapter']
      host     "localhost"
      database db['database']
      username db['username']
      password db['password']
    end
  end

  passenger_apache2 do
    server_aliases node['redmine']['server_aliases']
  end

  #On RM 1.x, plugins are mixed in with the rails plugins.  I can't think of how to support that.
  unless rmversion < 2
    symlinks({"plugins" => "plugins"})
    purge_before_symlink ['plugins']
  end

  before_symlink do
    directory "#{node['redmine']['path']}/shared/plugins" do
      owner node['apache']['user']
      group node['apache']['group']
    end
  end

end

execute 'bundle exec rake generate_session_store' do
  cwd "#{node['redmine']['path']}/current"
  not_if { ::File.exists?("#{node['redmine']['path']}/current/config/initializers/secret_token.rb") }
end
