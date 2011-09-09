#
# Cookbook Name:: kedpm
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
require_recipe "python"

kedpm_url = "http://sourceforge.net/projects/kedpm/files/kedpm/0.4.0/kedpm-0.4.0.tar.gz/download"

easy_install_package "pycrypto"

# It'd be nice to do this with easy_install_package like above, but the
# proveider doesn't support urls or files as sources.  See CHEF-1695
execute "easy_install #{kedpm_url}"
