name "round-three"
description "umasstransit.org 'round-three'.  Our core web-app"

# Everything but SSL
base = [
  "role[round-three-base]",
  "recipe[round-three::faye]",
  "recipe[fuelfocus-api]"
]

run_list base

env_run_lists(
  "_default" => base,
  "development" => base,
  "production" => base + ["recipe[round-three::ssl]"]
)
