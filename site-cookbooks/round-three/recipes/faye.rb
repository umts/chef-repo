#
# Cookbook Name:: round-three
# Recipe:: faye
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#

template "/etc/init.d/faye.conf" do
  source "faye.conf.erb"
  mode   "0755"
  variables(
    :round_three_dir => node['round-three']['dir'],
    :faye_port => node['round-three']['faye-port'],
    :bundler => node['rbenv']['root_path']
  )
end

service "faye" do
	case node[:platform]
  when "ubuntu"
    if node[:platform_version].to_f >= 9.10
      provider Chef::Provider::Service::Upstart
    end
  end
  action [:enable, :start]
end
