require 'openssl'

name        "redmine"
description "Sets up redmine with some setup tweaks"

pw = String.new

while pw.length < 20
  pw << OpenSSL::Random.random_bytes(1).gsub(/\W/, '')
end

# These should get merged with the defaults in the cookbook
override_attributes(
  "redmine" => {
    "revision" => "2.0.3",
    "path" => "/srv/redmine",
    "server_aliases" => [ "redmine.umasstransit.org" ],
    "databases" => {
      "password" => pw
    },
    "packages" => {
      "scm" => []   #git is always installed
    },
    "email" => {
      "method" => "smtp",
      "address" => "mailhub.oit.umass.edu"
    }
  },
  "build_essential" => {
    "compiletime" => true
  }
)

run_list "recipe[redmine]", "recipe[redmine-custom]"
