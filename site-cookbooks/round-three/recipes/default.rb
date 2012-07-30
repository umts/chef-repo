#
# Cookbook Name:: round-three
# Recipe:: default
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#
require_recipe "git"
require_recipe "postgresql::server"
require_recipe "xml"
require_recipe "ruby-193"
round_three_secrets = Chef::EncryptedDataBagItem.load("apps", "round-three")

application "round-three" do
  path "/srv/round-three"
  owner node['apache']['user']
  group node['apache']['group']

  repository "git@github.com:umts/round-three.git"
  deploy_key round_three_secrets['deploy_key']

  purge_before_symlink %w{log tmp/pids public/system}
  create_dirs_before_symlink %w{tmp public config}
  symlinks({"system" => "public/system", "pids" => "tmp/pids", "log" => "log"})

  rails do
    gems ['bundler']
    database do
      host    'localhost'
      adapter 'postgresql'
      username 'round-three'
      password round_three_secrets['passwords']['database']
    end
  end

  passenger_apache2 do
    server_aliases ["demo.umasstransit.org"]
  end
end
