#
# Cookbook Name:: ruby-193
# Recipe:: default
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#
node.set['rbenv']['rubies'] = [ "1.9.3-p194" ]

require_recipe "ruby_build"
require_recipe "rbenv::system"

rbenv_global "1.9.3-p194"
