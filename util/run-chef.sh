#!/bin/bash
#
# Author:: Ash Berlin (ash_github@firemirror.om)
# Copyright:: Copyright (c) 2011 DigiResults Ltd.
# License:: Apache License, Version 2.0
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
set -e

# Typically /var/run/chef/client.pid (init.d) or /etc/sv/chef-client/supervise/pid (runit)
pid_file="/var/run/chef/client.pid"
log_file="/var/log/chef/client.log"

declare tail_pid

on_exit() {
  rm -f $pipe
  [ -n "$tail_pid" ] && kill $tail_pid
}

trap "on_exit" EXIT ERR

pipe=/tmp/pipe-$$
mkfifo $pipe

tail -fn0 "$log_file" > $pipe &

tail_pid=$!

sudo kill -USR1 $(cat "$pid_file")
sed -r '/(ERROR: Sleeping for [[:digit:]]+ seconds before trying again|INFO: Report handlers complete)$/{q}' $pipe