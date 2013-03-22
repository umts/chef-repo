maintainer       "UMass Transit Service"
maintainer_email "transit-mis@admin.umass.edu"
license          "All rights reserved"
description      "Installs/Configures round-three"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ application application_ruby git database postgresql rbenv shibboleth ssl users sudo xml }.each do |cb|
  depends cb
end
