name "chef-client"
description "Base role applied to all nodes making them chef clients"
override_attributes(
  "chef_client" => {
    "init_style" => "init"
    "server_url" => "https://transit-chef.admin.umass.edu/"
  }
)
run_list(
  "recipe[chef-client::delete_validation]",
  "recipe[chef-client::config]",
  "recipe[chef-client]"
)
