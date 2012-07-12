#
# Cookbook Name:: redmine-custom
# Recipe:: markdown
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
gem_package "redcarpet" do
  action :install
end

if node["redmine"]["revision"] < "2"
  git "#{node["redmine"]["path"]}/vendor/plugins/redmine_redcartpet_formatter" do
    repository "git://github.com/alminium/redmine_redcarpet_formatter.git"
    reference  "v1.1.1"
    user       node["apache"]["user"]
    group      node["apache"]["group"]
    action     :export
  end
else
  git "#{node["redmine"]["path"]}/plugins/redmine_redcarpet_formatter" do
    repository "git://github.com/alminium/redmine_redcarpet_formatter.git"
    reference  "v2.0.1"
    user       node["apache"]["user"]
    group      node["apache"]["group"]
    action     :export
  end
end
