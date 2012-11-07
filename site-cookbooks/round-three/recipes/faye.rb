#
# Cookbook Name:: round-three
# Recipe:: faye
#
# Copyright 2012, UMass Transit Service
#
# All rights reserved - Do Not Redistribute
#

service "faye" do
	start_command "#{default['rbenv']['root_path']}/shims/bundle exec rackup #{default['round-three']['dir']}/current/private_pub.ru -s thin -E production"
	case node[:platform]
  when "ubuntu"
    if node[:platform_version].to_f >= 9.10
      provider Chef::Provider::Service::Upstart
    end
  end
  action [:enable, :start]
end