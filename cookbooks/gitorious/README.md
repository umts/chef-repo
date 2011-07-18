Description
===========
This recipe sets up and installs Gitorious.  It is, at its heart a Rails
application, so perhaps I should have used the "application" cookbook,
but there are so many weird pre requisites that I decided to stick with
a more direct approach.

Most of this cookbook came from [here][upstream], but I made a few
adjustments.  The larges one was pulling out the MySQL packages and
database creation.  Which brings me to the next section.

Requirements
============
This cookbook looks up database settings in the 'apps' databag.  See
"usage" below.

Attributes
==========
There's a bunch of them, all created by the original author, and I think
they're all documented in the metadata.

Usage
=====
While you don't need a full 'app' as you do with the [application][app]
cookbook, you do need at least a minimal database definition in your
'apps' databag, like so:

    {
      "id": "gitorious",
      "database_master_role": [
        "gitorious_database_master"
      ],
      "databases": {
        "production": {
          "reconnect": "true",
          "encoding": "utf8",
          "username": "git",
          "adapter": "mysql",
          "password": "some_password",
          "database": "gitorious_production"
        }
      }
    }

Use the [database][database] cookbook (A dependency of this one) to install
MySQL and create the database:

* Create a role named "gitorious_database_master" with the following
  simple run-list:
    name     "gitorious_database_master"
    run_list "recipe[database::master]"
* Assign that role to a node _before_ using this cookbook.

[upstream]: https://github.com/rosenfeld/gitorious-cookbooks
[app]:      https://github.com/opscode/cookbooks/tree/master/application
[database]: https://github.com/opscode/cookbooks/tree/master/database
