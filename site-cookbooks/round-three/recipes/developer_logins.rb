#
# Cookbook Name:: round-three
# Recipe:: developer_logins
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#
users_manage "developers" do
  group_id 2400
  action [ :remove, :create ]
end

node['authorization']['sudo']['groups'] << 'developers'
