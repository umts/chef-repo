Overview
========
Every Chef installation needs a Chef Repository. This is the place where
cookbooks, roles, config files and other artifacts for managing systems
with Chef will live.

Repository Directories
======================
This repository contains several directories, and each directory contains
a README file that describes what it is for in greater detail, and how to
use it for managing your systems with Chef.

* `cookbooks/` - Cookbooks that are internal to the workings of your Chef
  workstation setup.
* `data_bags/` - Store data bags and items in .json in the repository.
* `environments/` - Contains chef environment files.
* `roles/` - Store roles in .rb or .json in the repository.
* `site-cookbooks/` - Cookbooks that you've created and are keeping in
  this repository

Configuration
=============
The repository uses a configuration file, `.chef/knife.rb` which is a
repository-specific configuration file for knife. For more information about
configuring Knife, see the [Knife documentation][knifedoc].

This particular repository comes with a slightly UMTS specific `.chef/knife.rb`
file.  It expects the following things:

* That your chef server username is the same as either your local username _or_
  the value of the `CHEF\_SERVER\_USER` environment variable (set this
  in your profile somewhere if necessary).
* That your orgname (OpsCode Platform only) is either "umts" or set in the
  `ORGNAME` environment variable
* That your client key is stored in `~/.chef/username.pem` (where "username"
  is your chef server username mentioned above)
* That your validation key is stored in `~/.chef/orgname-validator.pem`

ChefDK
======
We recommend use of [chef-dk][chef-dk], and as such, the `.ruby\_version` in
this repository is set to "system".  If you have [direnv][direnv]
installed, it will use the `.envrc` in this repo to set up your `PATH`
and various `GEM\_SOMETHING` environment variables to work properly with
chef-dk.

Berkshelf
=========
Cookbook dependencies are manged using [Berkshelf][berks]. This is
different than a typical chef-repo where the `cookbooks/` directory
typically contains your cookbooks.  Instead, you specify their location
and version constraints in the `Berksfile` and then use `berks install`
to put them in your berkshelf.  This is located in `~/.berkshelf/cookbooks` by
default if you're interested in poking around.

It is possible to store cookbooks in this repository; that's what the
`site-cookbooks` directory is for. However, that directory is not in the
`cookbook_path`.  If you add a cookbook there, also add it to the
`Berksfile` with a `path:` specification.

Note that, in general, the way we organize our cookbooks is to have one
cookbook per git repository.

Also use berkshelf to upload cookbooks: `berks upload [COOKBOOKS]`

Next Steps
==========
Read the README file in each of the subdirectories for more information about
what goes in those directories.

[knifedoc]: http://help.opscode.com/faqs/chefbasics/knife
[lib]: https://github.com/applicationsonline/librarian
[chef-dk]: https://downloads.chef.io/chef-dk/
[direnv]: http://direnv.net/
[berks]: http://berkshelf.com/
