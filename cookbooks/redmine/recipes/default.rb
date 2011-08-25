#
# Author: Joshua Timberman <joshua@housepub.org>
# Cookbook Name:: redmine
# Recipe:: default
#
# Copyright 2008-2009, Joshua Timberman
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

include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "passenger_apache2::mod_rails"

bash "install_redmine" do
  cwd "/srv"
  user "root"
  code <<-EOH
    wget http://rubyforge.org/frs/download.php/#{node[:redmine][:dl_id]}/redmine-#{node[:redmine][:version]}.tar.gz
    tar xf redmine-#{node[:redmine][:version]}.tar.gz
    chown -R #{node[:apache][:user]} redmine-#{node[:redmine][:version]}
  EOH
  not_if { ::File.exists?("/srv/redmine-#{node[:redmine][:version]}/Rakefile") }
end

link "/srv/redmine" do
  to "/srv/redmine-#{node[:redmine][:version]}"
end

app = data_bag_item('apps', 'redmine')

if app["database_master_role"]
  dbm = nil
  # If we are the database master
  if node.run_list.roles.include?(app["database_master_role"][0])
    dbm = node
  else
  # Find the database master
    results = search(:node, "role:#{app["database_master_role"][0]} AND chef_environment:#{node.chef_environment}", nil, 0, 1)
    rows = results[0]
    if rows.length == 1
      dbm = rows[0]
    end
  end

  # Assuming we have one...
  if dbm
    template "/srv/redmine-#{node[:redmine][:version]}/config/database.yml" do
      source "database.yml.erb"
      mode "644"
      variables(
        :host => dbm['fqdn'],
        :databases => app['databases']
      )
    end
  else
    Chef::Log.warn("No node with role #{app["database_master_role"][0]}, database.yml not rendered!")
  end
end

execute "bundle install" do

end

execute "rake db:migrate RAILS_ENV='#{node.chef_environment}'" do
  user node[:apache][:user]
  cwd "/srv/redmine-#{node[:redmine][:version]}"
  not_if { ::File.exists?("/srv/redmine-#{node[:redmine][:version]}/db/schema.rb") }
end

web_app "redmine" do
  docroot "/srv/redmine/public"
  template "redmine.conf.erb"
  server_name "redmine.#{node[:domain]}"
  server_aliases [ "redmine", node[:hostname] ]
  rails_env node.chef_environment
end
