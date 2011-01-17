#
# Cookbook Name:: php
# Attributes:: php
#
# Copyright 2008-2009, Opscode, Inc.
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

# Where the various parts of php5 are
case platform
when "redhat","centos","fedora","suse"
  set[:php][:dir]     = "/etc/php.d"
when "debian","ubuntu"
  set[:php][:dir]     = "/etc/php/conf.d"
else
  set[:php][:dir]     = "/etc/php.d"
end
