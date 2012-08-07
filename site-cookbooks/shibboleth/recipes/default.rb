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

service "shibd" do
  supports :restart => true
  action [:enable, :start]
end

execute 'shib-keygen' do
  cwd '/etc/shibboleth'
  creates '/etc/shibboleth/sp-cert.pem'
  command "shib-keygen -f -h #{node['fqdn']} -e #{node['fqdn']}/shibboleth && chmod 644 /etc/shibboleth/sp-key.pem"
  notifies :run, "execute[shib-metagen]", :immediately
  notifies :restart, 'service[shibd]'
end

execute 'shib-metagen' do
  cwd '/etc/shibboleth'
  creates "/etc/shibboleth/#{node['fqdn']}-metadata.xml"
  command "shib-metagen -c /etc/shibboleth/sp-cert.pem -h #{node['fqdn']} > #{node['fqdn']}-metadata.xml"
  action :nothing
  notifies :restart, 'service[shibd]'
end

remote_file '/etc/shibboleth/idp-metadata.xml' do
  source "#{node['shibboleth']['idp']}/idp/profile/Metadata/SAML"
  mode '0644'
  notifies :restart, 'service[shibd]'
end

template '/etc/shibboleth/shibboleth2.xml' do
  source 'shibboleth2.xml.erb'
  mode '0644'
  variables(
    :idp_url => "#{node['shibboleth']['idp']}/idp/shibboleth"
  )
  notifies :restart, 'service[shibd]'
end

cookbook_file '/etc/shibboleth/attribute-map.xml' do
  mode '0644'
  notifies :restart, 'service[shibd]'
end

apache_module 'shib2'
