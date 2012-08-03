#
# Cookbook Name:: round-three
# Recipe:: default
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#
require 'rubygems'
Gem.clear_paths
require 'pg'

require_recipe "postgresql::server"

round_three_secrets = Chef::EncryptedDataBagItem.load("apps", "round-three")
postgresql_connection = {:host => "127.0.0.1",
                         :port => 5432,
                         :username => 'postgres',
                         :password => node['postgresql']['password']['postgres']}

postgresql_database 'round_three_production' do
  connection postgresql_connection
  action :create
  owner 'round_three'
  action :nothing
end

ruby_block "change-rt-db-password" do
  block do
    c = PGconn.connect(:user=> postgresql_connection[:username],
                       :dbname=>'postgres',
                       :host =>  postgresql_connection[:host],
                       :password=> postgresql_connection[:password])
    c.exec("ALTER ROLE round_three ENCRYPTED PASSWORD '#{round_three_secrets['passwords']['database']}'")
  end
  not_if do
    begin
      c = PGconn.connect(:user=> 'round_three',
                         :dbname=> 'round_three_production',
                         :host => postgresql_connection[:host],
                         :password=> round_three_secrets['passwords']['database'])
    rescue PGError
      false
    end
  end
  action :nothing
end

execute "create-rt-database-user" do
  user 'postgres'
  command "createuser -U #{postgresql_connection[:username]} -SDRw round_three"
  only_if do
    c = PGconn.connect(:user=> postgresql_connection[:username],
                       :dbname=>'postgres',
                       :host => postgresql_connection[:host],
                       :password=> postgresql_connection[:password])
    r = c.exec("SELECT COUNT(*) FROM pg_user WHERE usename='round_three'")
    r.entries[0]['count'].to_i == 0
  end
  notifies :create, "postgresql_database[round_three_production]", :immediately
  notifies :create, "ruby_block[change-rt-db-password]", :immediately
end
