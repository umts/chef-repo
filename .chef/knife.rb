current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "werebus"
client_key               "#{current_dir}/werebus.pem"
validation_client_name   "umts-validator"
validation_key           "#{current_dir}/umts-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/umts"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
