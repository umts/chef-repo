maintainer       "UMass Transit Service"
maintainer_email "transit-mis@admin.umass.edu"
license          "Apache 2.0"
description      "Installs/Configures vmware-tools"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w(apt yum).each do |cb|
  depends cb
end

supports "ubuntu", "<= 10.11"
supports "centos", ">=5"
supports "redhat", ">=5"

attribute "virtualization/vmware_version",
  :dispay_name => "VMWare host version",
  :description => "What version of VMWare are we running under?",
  :type        => "string",
  :choice      => [ "3.5u2", "3.5u3", "3.5u4", "3.5u5", "4.0", "4.0u1", "4.0u2", "4.0u3", "4.1", "4.1u1" ],
  :required    => "required",
  :default     => "4.1"
