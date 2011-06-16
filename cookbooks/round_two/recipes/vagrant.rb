# Vagrant specific tweeks - removes the application generated web_app def
# and replaces it with one that points to the vagrant share.
#

include_recipe "apache2"

web_app "round_two_vagrant" do
  docroot "/vagrant"
  template "round_two.conf.erb"
  server_name "round_two.#{node[:domain]}"
  log_dir node[:apache][:log_dir]
  rails_env node.chef_environment
end

apache_site "round_two" do
  enable false
end
