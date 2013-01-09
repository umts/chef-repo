#
# Cookbook Name:: round-three
# Recipe:: ssl
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#
include_recipe "ssl"
include_recipe "apache2::mod_ssl"

domain = "transit-demo.admin.umass.edu"

web_app "round-three-ssl" do
  template        "round-three-ssl.conf.erb"
  docroot         "#{node['round-three']['dir']}/current/public"
  server_name     "round-three.#{node['domain']}"
  server_aliases  ["demo.umasstransit.org", "transit-demo.admin.umass.edu"]
  log_dir         node['apache']['log_dir']
  rails_env       node.chef_environment =~ /_default/ ? "production" : node.chef_environment
  ssl_key         "/etc/ssl/#{domain}.key"
  ssl_certificate "/etc/ssl/#{domain}.cert"
  ssl_chain       "/etc/ssl/in-common-imtermediate.cert"
end

apache_site "round-three.conf" do
  enable false
end

ssl_certificate "transit-demo" do
  name        domain
  ca          "InCommon"
  key         "/etc/ssl/#{domain}.key"
  certificate "/etc/ssl/#{domain}.cert"
  days        365
end

cookbook_file "/etc/ssl/in-common-intermediate.cert" do
  mode '0644'
  notifies :restart, 'service[apache2]'
end
