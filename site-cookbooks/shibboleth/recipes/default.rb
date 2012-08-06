#
# Cookbook Name:: shibboleth
# Recipe:: default
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#
require_recipe 'apache2'

package 'libapache2-mod-shib2'
