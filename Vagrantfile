# Read in your knife configuration.  This should leave you with a
# Chef::Config object that is the same as if you were running 'knife'
# from within this directory.  That is, if you have a valid knife.rb file
# in either ~/.chef or ./.chef, this Vagrantfile will use that file to
# figure out the details of your chef server.
require 'chef/config'
require 'chef/knife'
require 'chef/rest'

Chef::Knife.new.configure_chef

# Remove the node and client from the chef-server when we're destroying the vm.
module Vagrant
 module Provisioners
  class ChefClient
    def cleanup
      user = ENV['CHEF_SERVER_USER'] || ENV['USER']
      node = "vagrant-test-#{user}"
      puts "cleaning up #{node} on chef server"

      begin
        ::Chef::REST.new(::Chef::Config[:chef_server_url]).delete_rest("clients/#{node}")
        ::Chef::REST.new(::Chef::Config[:chef_server_url]).delete_rest("nodes/#{node}")
      rescue Net::HTTPServerException => e
        if e.message == '404 "Not Found"'
          puts "Server says it doesn't exist continuing.."
        else
          puts "Server reported: #{e.message}\nYou will have to clean the client/node by hand"
        end
      rescue Exception => e
        puts "Caught error while cleaning node from server:\n #{e.message}\nYou will have to clean the client/node by hand"
      end

    end
  end
 end
end

# Warn the user if they don't have a encrypted data bag secret file.  Many
# cookbooks in this repository will work file without it, but some  won't.
data_bag_secret =  File.join(File.dirname(__FILE__), "encrypted_data_bag_secret")
unless File.exists? data_bag_secret
  puts "WARN: You don't have a 'encrypted_data_bag_secret' file in the the project root.
        Some recipes may rely on encrypted data bags and will fail -- proceed with caution.
        Get this file from the password database or another user.".gsub(/[ \t]+/, " ")
end

Vagrant::Config.run do |config|
  config.vm.box = "umts-precise32-rbenv"
  config.vm.box_url = "https://s3.amazonaws.com/umts-vagrantboxes/umts-precise32-rbenv.box"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080
  config.vm.forward_port 443, 8443

  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = Chef::Config[:chef_server_url]
    chef.validation_key_path = Chef::Config[:validation_key]
    chef.validation_client_name = Chef::Config[:validation_client_name]
    chef.environment = "development"

    user = ENV['CHEF_SERVER_USER'] || ENV['USER']
    chef.node_name = "vagrant-test-#{user}"

    if File.exists? data_bag_secret
      chef.encrypted_data_bag_secret_key_path = data_bag_secret
      chef.encrypted_data_bag_secret = "/home/vagrant/encrypted_data_bag_secret"
    end

    # Here you can set attributes on the node
    chef.json.merge!({
      'tz' => 'America/New_York',
      'authorization' => {
        'sudo' => {
          'users' => ['vagrant'],
          'passwordless' => true
        }
      }
    })

    # The runlist for the vm: an array of recipes and roles such as
    # "recipe[foo]" or "role[bar]"
    chef.run_list = [
      "role[transit_server]",
      "role[ubuntu_server]"
    ]
  end
end
