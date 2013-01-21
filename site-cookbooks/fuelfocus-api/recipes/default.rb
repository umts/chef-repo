#
# Cookbook Name:: fuelfocus-api
# Recipe:: default
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#
require_recipe "git"
require_recipe "build-essential"

ff_secrets = Chef::EncryptedDataBagItem.load('apps', 'fleetfocus-api')
deploy_path = "/srv/fleetfocus-api"

rbenv_gem "bundler"

application "fleetfocus-api" do
  path deploy_path
  repository "git://github.com/umts/fleetfocus-api.git"

  owner 'root'
  group 'root'
  packages %w{ freetds-dev }

  symlinks({"pids" => "tmp/pids", "log" => "log", "thin.yml" => "config/thin.yml"})
  create_dirs_before_symlink ['tmp']

  # "rails" for purposes of db config and vendoring bundle
  rails do
    bundler true
    bundler_deployment false
    database do
      adapter 'sqlserver'
      host     ff_secrets['dbhost']
      database ff_secrets['dbname']
      username ff_secrets['dbuser']
      password ff_secrets['dbpassword']
    end
  end

  before_symlink do
    template "#{deploy_path}/shared/thin.yml" do
      mode "0755"
      variables(
        :dir => "#{deploy_path}/current/",
        :port => 4567,
        :environment => node.chef_environment
      )
    end

    %w{log pids}.each do |dir|
      directory "#{deploy_path}/shared/#{dir}" do
        mode "0755"
      end
    end
  end

  notifies :restart, 'service[fleetfocus-api]'
end

template "/etc/init.d/fleetfocus-api" do
  source "thin-initd.erb"
  mode   "0755"
  variables(
    :app_path => "#{deploy_path}/current",
    :config => "#{deploy_path}/current/config/thin.yml",
    :bundler => "/usr/local/rbenv/shims/bundle"
  )
end

service "fleetfocus-api" do
  supports :restart => true
  action [:enable, :start]
  pattern 'thin server \((?:\d{1,3}\.){3}\d{1,3}:4567\)'
end
