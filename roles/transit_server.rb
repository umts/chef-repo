name        "transit_server"
description "The basics that all Transit servers need as a base"

default_attributes(
  "ntp" => {
    "servers" => [ "ntp.umass.edu" ]
  }
)

run_list    "recipe[sudo]", "recipe[users::sysadmins]", "recipe[ntp]"
