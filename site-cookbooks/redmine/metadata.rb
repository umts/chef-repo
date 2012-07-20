maintainer       "UMass Transit Service"
maintainer_email "transit-mis@admin.umass.edu"
license          "Apache 2.0"
description      "Install Redmine with the application cookbook"
version          "0.0.1"

recipe "redmine", "Install the Redmine application from the source"

%w{ mysql git application application_ruby database }.each do |dep|
  depends dep
end
