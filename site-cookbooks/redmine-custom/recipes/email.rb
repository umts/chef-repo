#
# Cookbook Name:: redmine-custom
# Recipe:: email
#
# Copyright 2012, UMass Transit Service
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
template "#{node["redmine"]["path"]}/config/configuration.yml" do
  source "configuration.yml.erb"
  owner node["redmine"]["user"]
  group node["redmine"]["group"]
  mode "644"
  evars = %w{method address port authentication domain user_name password}
  variables Hash[ evars.map{ |v| [v.to_sym, node["redmine"]["email"][v]] } ]
end
