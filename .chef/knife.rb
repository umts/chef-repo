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
chef_server_url           "https://api.opscode.com/organizations/#{orgname}"

encrypted_data_bag_secret File.join(current_dir, '..', 'encrypted_data_bag_secret')

cookbook_copyright       "UMass Transit Service"
cookbook_email           "transit-mis@admin.umass.edu"

if config_contexts.include? :chefdk
  chefdk.generator_cookbook File.join(current_dir, '..', 'code_generator')

  unless ARGV.include?('-c') || ARGV.include?('--copyright')
    chefdk.copyright_holder  "UMass Transit Service"
  end

  unless ARGV.include?('-m') || ARGV.include?('--email')
    chefdk.email 'transit-it@admin.umass.edu'
  end

  unless ARGV.include?('-I') || ARGV.include?('--license')
    chefdk.license 'apache'
  end
end
