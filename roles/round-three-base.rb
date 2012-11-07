name "round-three-base"
description "The application code and database server"

run_list(
  "recipe[round-three::application]",
  "recipe[round-three::database]"
)
