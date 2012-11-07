# Read in your knife configuration.  This should leave you with a
# Chef::Config object that is the same as if you were running 'knife'
# from within this directory.  That is, if you have a valid knife.rb file
# in either ~/.chef or ./.chef, this Vagrantfile will use that file to
# figure out the details of your chef server.
require 'chef/config'
require 'chef/knife'
Chef::Knife.new.configure_chef

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
  config.vm.forward_port 4567, 4567
  config.vm.forward_port 9292, 9292

  # Enable provisioning with chef server, specifying the chef server URL
  # and the path to the validation key (relative to this Vagrantfile).
  user = ENV['CHEF_SERVER_USER'] || ENV['USER']

  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = Chef::Config[:chef_server_url]
    chef.validation_key_path = Chef::Config[:validation_key]
    chef.validation_client_name = Chef::Config[:validation_client_name]
    chef.environment = "development"
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
      "role[ubuntu_server]",
      "role[round-three]"
    ]
  end
end
