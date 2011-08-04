#
# Cookbook Name:: vmware-tools
# Recipe:: default
#
# Copyright 2011, UMass Transit Service
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
vm_version = node["virtualization"]["vmware_version"]
gpg_key = "http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub"

case node[:platform]
when "ubuntu"
  include_recipe "apt"

  apt_repository "vmware-tools" do
    uri "http://packages.vmware.com/tools/esx/#{vm_version}/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    key gpg_key
    action :add
  end

  #"server", "generic", "virtual", etc
  kernel_type = node[:kernel][:release].split("-").last

  if /3.5/ =~ vm_version
    package "oven-vm-tools-kmod-#{kernel_type}"
  else
    package "vmware-open-vm-tools-kmod-#{kernel_type}"
  end

  package "vmware-tools-esx-nox"

when "centos", "redhat"
  include_recipe "yum"

  #also works for CentOS:
  if node[:lsb][:release]
    rhel_major_version = node[:lsb][:relase].split(".").first
  else
    raise "Aw SHit"
  end

  yum_key "VMWARE-PACKAGING-GPG-RSA-KEY" do
    url gpg_key
    action :add
  end

  yum_repository " vmware-tools" do
    name   "VMWare Tools"
    url    "http://packages.vmware.com/tools/esx/#{vm_version}/rhel#{rhel_major_version}/#{node[:kernel][:machine]}"
    key    "VMWARE-PACKAGING-GPG-RSA-KEY"
    action :add
  end

  package "vmware-tools"
end
