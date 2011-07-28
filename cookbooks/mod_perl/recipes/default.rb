#
# Cookbook Name:: mod_perl
# Recipe:: default
#
# Copyright 2011, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"
include_recipe "perl"

case node[:platform]
when "debian", "ubuntu"
  package "libapache2-mod-perl2" do
    action :install
  end
when "centos", "redhat", "fedora"
  package "mod_perl" do
    action :install
    notifies :run, resources(:execute => "generate-module-list"), :immediately
  end
end

apache_module "perl"
