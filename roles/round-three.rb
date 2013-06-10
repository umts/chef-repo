name "round-three"
description "umasstransit.org 'round-three'.  Our core web-app"

#TODO: Remove this after deployment is sorted out. This is duplicated in
#the transit_server role.
default_attributes(
  'authorization' => {
    'sudo' => {
      'passwordless' => true
    }
  }
)

# Everything but SSL
base = [
  "role[round-three-base]",
  "recipe[round-three::developer_logins]",
  "recipe[round-three::faye]",
  "recipe[fuelfocus-api]"
]

run_list base

env_run_lists(
  "_default" => base,
  "development" => base,
  "production" => base + ["recipe[round-three::ssl]",
                          "recipe[round-three::shibboleth]",
                          "recipe[round-three::db-dumps]"]
)
