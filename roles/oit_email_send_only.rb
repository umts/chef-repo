name "oit_email_send_only"
description "Set up ssmtp to send via OIT's mail server"
override_attributes(
  "ssmtp" => {
    "smtp_server_host" => "mailhub.oit.umass.edu",
    "smtp_server_port" => false,
    "use_starttls" => false,
    "use_auth" => false
  }
)
run_list "recipe[ssmtp]"
