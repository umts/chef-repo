name        "oit_server"
description "Servers that are housed in OIT's VM infrastructure"

default_attributes(
  'authorization' => {
    'sudo' => {
      'groups' => ['sysadmin', 'oitadmins']
    }
  }
)
