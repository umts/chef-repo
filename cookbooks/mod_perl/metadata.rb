maintainer       "UMass Transit Service"
maintainer_email "transit-mis@admin.umass.edu"
license          "Apache 2.0"
description      "Installs/Configures mod_perl"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ubuntu debian redhat centos fedora}.each do |os|
  supports os
end

%w{apache2 perl}.each do |cb|
  depends cb
end
