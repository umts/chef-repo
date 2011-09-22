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
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  # config.vm.network "33.33.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port "http", 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data")


  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  user = ENV['CHEF_SERVER_USER'] || ENV['USER']

  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = Chef::Config[:chef_server_url]
    chef.validation_key_path = Chef::Config[:validation_key]
    chef.validation_client_name = Chef::Config[:validation_client_name]
    chef.environment = "development"
    chef.node_name = "vagrant-test-#{user}"

    chef.encrypted_data_bag_secret_key_path = data_bag_secret if File.exists? data_bag_secret

    # Here you can set attributes on the node
    chef.json.merge!({
      'tz' => 'America/New_York'
    })

    # The runlist for the vm: an array of recipes and roles such as
    # "recipe[foo]" or "role[bar]"
    chef.run_list = [
      "recipe[apt]",
      "recipe[timezone]"
    ]
  end
end
