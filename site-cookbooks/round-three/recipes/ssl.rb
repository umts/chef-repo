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

web_app "round-three-ssl" do
  template       "round-three-ssl.conf.erb"
  docroot        "#{node['round-three']['dir']}/current/public"
  server_name    "round-three.#{node['domain']}"
  server_aliases ["demo.umasstransit.org", "transit-demo.admin.umass.edu"]
  log_dir        node['apache']['log_dir']
end

apache_site "round-three.conf" do
  enable false
end

ssl_certificate "transit-demo" do
  domain = "transit-demo.admin.umass.edu"

  name        domain
  ca          "InCommon"
  key         "/etc/ssl/#{domain}.key"
  certificate "/etc/ssl/#{domain}.cert"
  days        365
end
