maintainer        "UMass Transit Service"
maintainer_email  "transit-mis@admin.umass.edu"
license           "Apache 2.0"
description       "Installs the Gitorious web app"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "gitorious", "Installs Gitorious"

%w{ ubuntu debian }.each do |os|
  supports os
end

%w{ apache2 }.each do |cb|
  depends cb
end

attribute "gitorious",
  :display_name => "Gitorious Hash",
  :description => "Hash of Gitorious attributes",
  :type => "hash"

attribute "gitorious/storage_dir",
  :display_name => "Gitorious Storage Directory",
  :description => "The location that Gitorious stores git repos and tarballs",
  :default => "/var/git"

attribute "gitorious/deploy_path",
  :display_name => "Gitorious Deploy path",
  :description => "The location that the Gitorious web app is deployed to",
  :default => "/srv/gitorious"

attribute "gitorious/host",
  :display_name => "Gitorious Host",
  :description => "The hostname that Gitorious answers to",
  :default => "git.umasstransit.org"

grouping "gitorious/git",
  :title => "Gitorious Git repository information",
  :description => "Information about where to get Gitorious from"

attribute "gitorious/git/url",
  :display_name => "Gitorious git url",
  :description => "The git url of a repository that contains the Gitorious source code",
  :default => "git://gitorious.org/gitorious/mainline.git"

attribute "gitorious/git/reference",
  :display_name => "Gitorious git ref",
  :description => "The ref to use when checking out Gitorious' source",
  :default => "master"

attribute "gitorious/support_email",
  :display_name => "Gitorious Support Email",
  :description => "The email that recieves user support questions",
  :default => "support@git.umasstransit.org"

attribute "gitorious/notification_emails",
  :display_name => "Gitorious Notification Emails",
  :description => "The email(s) that send notifications",
  :default => "support@git.umasstransit.org"

attribute "gitorious/public_mode",
  :display_name => "Gitorious Public mode",
  :description => "Is this Gitorious install open to the public?",
  :default => false

attribute "gitorious/locale",
  :display_name => "Gitorious Locale",
  :default => "en"

attribute "gitorious/only_admin_create",
  :display_name => "Gitorious Admin creation",
  :description => "Can only admin create projects/repositories?",
  :default => false

attribute "gitorious/hide_http_clone_urls",
  :display_name => "Gitorious Hide http Clone URLs",
  :description => "Hide the http clone urls from users (http takes more work to setup",
  :default => true

grouping "gitorious/admin",
  :title => "Gitorious Admin",
  :description => "The initial admin user"

attribute "gitorious/admin/email",
  :display_name => "Gitorious Admin Email Address",
  :description => "The email address of the initial admin user",
  :default => "admin@git.umasstransit.org"

attribute "gitorious/admin/password",
  :display_name => "Gitorious Admin Password",
  :description => "The password of the initial admin user",
  :default => "password"
