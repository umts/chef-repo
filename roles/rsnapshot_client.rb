name "rsnapshot_client"
description "A server that has tasty backup targets"

default_attributes(
  'authorization' => {
    'sudo' => {
      'include_sudoers_d' => true
    }
  }
)

run_list "recipe[rsnapshot::client]"
