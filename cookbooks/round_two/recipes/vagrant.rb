# Vagrant specific tweeks - removes the application generated web_app def
# and replaces it with one that points to the vagrant share.
#

include_recipe "apache2"

#database.yml output (this is super overkill, but it might allow you to
#have a seperate DB VM, or use (shudder) the live db for development
app = data_bag_item("apps", "round_two")
if app["database_master_role"]
  dbm = nil
  # If we are the database master
  if node.run_list.roles.include?(app["database_master_role"][0])
    dbm = node
  else
  # Find the database master
    results = search(:node, "role:#{app["database_master_role"][0]} AND chef_environment:#{node.chef_environment}", nil, 0, 1)
    rows = results[0]
    if rows.length == 1
      dbm = rows[0]
    end
  end

  # Assuming we have one...
  if dbm
    template "/vagrant/config/database.yml" do
      source "database.yml.erb"
      mode "644"
      variables(
        :host => dbm['fqdn'],
        :databases => app['databases'],
        :rails_env => 'development'
      )
    end
  else
    Chef::Log.warn("No node with role #{app["database_master_role"][0]}, database.yml not rendered!")
  end
end

#Create a web app config that points to the vagrant shared folder
web_app "round_two_vagrant" do
  docroot "/vagrant/public"
  template "round_two.conf.erb"
  server_name "round_two.#{node[:domain]}"
  log_dir node[:apache][:log_dir]
  rails_env node.chef_environment
end

#Disable the internal Apache site definition
apache_site "round_two.conf" do
  enable false
end

#Link in the deployment bundle
link "/vagrant/.bundle" do
  to "#{app["deploy_to"]}/current/.bundle"
end
link "/vagrant/vendor/bundle" do
  to "#{app["deploy_to"]}/current/vendor/bundle"
end
