current_dir =            File.dirname(__FILE__)
user =                   ENV['OPSCODE_USER'] || ENV['USER']
orgname =                ENV['ORGNAME'] || 'umts'

log_level                :info
log_location             STDOUT
node_name                user
client_key               "#{ENV['HOME']}/.chef/#{user}.pem"
validation_client_name   "#{orgname}-validator"
validation_key           "#{ENV['HOME']}.chef/#{orgname}-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/#{orgname}"
cache_type               'BasicFile'
cache_options( :path =>  "#{ENV['HOME']}/.chef/checksums" )
cookbook_path [ "#{current_dir}/../cookbooks", "#{current_dir}/../site-cookbooks" ]

cookbook_copyright       "UMass Transit Service"
cookbook_email           "transit-mis@admin.umass.edu"
