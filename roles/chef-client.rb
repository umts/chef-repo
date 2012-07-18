name "chef-client"
description "Base role applied to all nodes making them chef clients"

run_list(
  "recipe[chef-client::delete_validation]",
  "recipe[chef-client::config]",
  "recipe[chef-client]"
)
