name "rsnapshot_server"
description "The central server that runs rsnapshot"

run_list "recipe[rsnapshot::server]"
