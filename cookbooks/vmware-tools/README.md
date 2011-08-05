Description
===========
This cookbook installs the VMWare Operating System Packages (OSP) for
Linux-based guests on ESX/ESXi hosts.  Wherever possible, it uses the
OS's package management system, and follows along with the install guide
included in the cookbook and also available [here][vmdocs].

Requirements
============
This cookbook requires the [apt][apt] or [yum][yum] cookbook in order to
install the 3rd-party repository.  For Redhat-based distros, you also
need the redhat-lsb package to allow ohai to determine what version of
RHEL or Centos you're running.

Attributes
==========
Just one: `virtualization/vmware_version`  This is a string like `4.0u2`
or the like that specifies what version the of VMWare the host is
running.  The default is `4.1`

[vmdocs]: http://www.vmware.com/support/pubs
[apt]:    https://github.com/opscode/cookbooks/tree/master/apt
[yum]:    https://github.com/opscode/cookbooks/tree/master/yum
