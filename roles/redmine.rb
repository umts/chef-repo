name        "redmine"
description "Sets up redmine with some setup tweaks"

# These should get merged with the defaults in the cookbook
default_attributes(
  "redmine" => {
    "revision" => "2.0.3",
    "path" => "/srv/redmine",
    "packages" => {
      "scm" => []   #git is always installed
    }
  }
)

run_list "recipe[redmine]", "recipe[redmine-custom]"
