
ssmtp Mash.new unless attribute?("ssmtp")
ssmtp[:smtp_server_host] = "smtp.#{domain}" unless ssmtp.has_key?(:smtp_server_host)
ssmtp[:smtp_server_port] = "587" unless ssmtp.has_key?(:smtp_server_port)
#ssmtp[:root] = undef unless ssmtp.has_key?(:root)
#ssmtp[:hostname] = fqdn unless smtp.has_key?(:hostname)
ssmtp[:domain] = domain unless ssmtp.has_key?(:domain)
ssmtp[:from_line_override] = true unless ssmtp.has_key?(:from_line_override)
ssmtp[:use_starttls] = true unless ssmtp.has_key?(:use_starttls)
ssmtp[:use_auth] = true unless ssmtp.has_key?(:use_auth)
#ssmtp[:auth_username] = undef unless ssmtp.has_key?(:auth_username)
#ssmtp[:auth_password] = undef unless ssmtp.has_key?(:auth_password)
ssmtp[:auth_method]   = "DIGEST-MD5" unless ssmtp.has_key?(:auth_method)