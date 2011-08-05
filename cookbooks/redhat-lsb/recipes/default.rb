#
# Cookbook Name:: redhat-lsb
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

ohai "reload-lsb" do
  action :nothing
  plugin "linux/lsb"
end

package "redhat-lsb" do
  action   :upgrade
  notifies :reload, resources(:ohai => "reload-lsb"), :immeadiately
end
