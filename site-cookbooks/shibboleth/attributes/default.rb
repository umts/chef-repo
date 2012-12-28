default['shibboleth']['idp'] = "https://idp.testshib.org"
default['shibboleth']['remote_user'] = "eppn persistent-id targeted-id"

default['shibboleth']['sessions']['lifetime'] = 28800
default['shibboleth']['sessions']['timeout'] = 3600
default['shibboleth']['sessions']['check_address'] = false
default['shibboleth']['sessions']['handler_ssl'] = false

default['shibboleth']['handlers']['metadata_generator'] = true
default['shibboleth']['handlers']['status'] = true
default['shibboleth']['handlers']['session'] = true
default['shibboleth']['handlers']['discovery_feed'] = true

default['shibboleth']['errors']['contact'] = "root@#{node['fqdn']}"
default['shibboleth']['errors']['logo'] = '/shibboleth-sp/logo.jpg'
default['shibboleth']['errors']['css'] = '/shibboleth-sp/main.css'
