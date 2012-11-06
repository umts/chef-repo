#
# Cookbook Name:: faye
# Recipe:: default
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#

gem_package "faye" do
	version "0.8.6"
  action :install
end

gem_package "faye-websocket" do
	version "0.4.6"
	action :install
end


file "/faye" do
  owner "root"
  group "root"
  mode "0744"
  action :create
  content %{
  require 'faye'
  Faye::WebSocket.load_adapter('thin')
  faye_server = Faye::RackAdapter.new(mount: '/faye', timeout: 45)
  run faye_server
  }
end

execute "startfaye" do
  command "rackup faye.ru -E production"
  action :nothing
end
