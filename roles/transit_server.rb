name        "transit_server"
description "The basics that all Transit servers need as a base"

default_attributes(
  "ntp" => {
    "servers" => [ "ntp.umass.edu" ]
  },
  'authorization' => {
    'sudo' => {
      'passwordless' => true
    }
  }
)

run_list "recipe[sudo]",
         "recipe[users::sysadmins]",
         "recipe[ntp]",
         "recipe[motd-tail]",
         "recipe[fuelfocus-api]",
