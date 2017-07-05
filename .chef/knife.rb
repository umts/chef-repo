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
cookbook_email           "transit-it@admin.umass.edu"
cookbook_license         "mit"

if config_contexts.is_a?(Hash) && config_contexts.include?(:chefdk) && chefdk.generator
  chefdk.generator_cookbook = File.join(File.dirname(__FILE__), '..', 'code_generator')
  chefdk.generator.license = cookbook_license
  chefdk.generator.copyright_holder = cookbook_copyright
  chefdk.generator.email = cookbook_email
end
