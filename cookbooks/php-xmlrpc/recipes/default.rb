#
# Cookbook Name:: php-xmlrpc
# Recipe:: default
#
# Copyright 2011, UMass Transit Services
#
# All rights reserved - Do Not Redistribute
#
include_recipe "php::php5"

package "php-xml" do
  case node[:platform]
  when "centos","redhat","fedora","suse"
    package_name "php-xml"
  when "debian","ubuntu"
    package_name "php-xml-parser"
  end
  action :install
  notifies :reload, resources(:service => "apache2"), :delayed
end

package "php-xml-rpc" do
  case node[:platform]
  when "centos","redhat","fedora","suse"
    package_name "php-xmlrpc"
  when "debian","ubuntu"
    package_name "php5-xmlrpc"
  end
  action :install
  notifies :reload, resources(:service => "apache2"), :delayed
end
