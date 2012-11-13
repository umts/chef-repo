require 'librarian/chef/integration/knife'

current_dir =             File.dirname(__FILE__)
home =                    ENV['HOME']
user =                    ENV['CHEF_SERVER_USER'] || ENV['USER']
orgname =                 ENV['ORGNAME'] || 'umts'

log_level                 :info
log_location              STDOUT
node_name                 user
client_key                File.join(home, '.chef', "#{user}.pem")
validation_client_name    "#{orgname}-validator"
validation_key            File.join(home, '.chef', "#{orgname}-validator.pem")
validation_key            "#{ENV['HOME']}/.chef/#{orgname}-validator.pem"
chef_server_url           "https://api.opscode.com/organizations/#{orgname}"
cache_type                'BasicFile'
cache_options( :path =>   File.join(home, '.chef', 'checksums'))
cookbook_path             Librarian::Chef.install_path
encrypted_data_bag_secret File.join(current_dir, '..', 'encrypted_data_bag_secret')

cookbook_copyright       "UMass Transit Service"
cookbook_email           "transit-mis@admin.umass.edu"
