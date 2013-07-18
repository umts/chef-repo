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
  },
  "ssl" => {
    "key_vault"    => "transit-mis@admin.umass.edu",
    "country"      => "US",
    "state"        => "MA",
    "city"         => "Amherst",
    "organization" => "UMass Transit Service",
    "department"   => "MIS",
    "email"        => "transit-mis@admin.umass.edu"
  },
  "openssh" => {
    "server" => {
      "max_startups" => "10:30:100"
    }
  },
  "apache" => {
    "traceenable" => "Off"
  }
)

run_list "recipe[sudo]",
         "recipe[users::sysadmins]",
         "recipe[ntp]",
         "recipe[motd-tail]"
