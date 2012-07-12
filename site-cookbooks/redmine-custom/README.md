Description
===========
This cookbook provides some configuration tweaks for the [Redmine][rm]
installation that is performed by juanje's redmine cookbook

Requirements
============
This cookbook uses that attributes that are set by the [redmine
cookbook][rmcb] and so that cookbook is a requirement.

Usage
=====
The default recipe is a meta-recipe that calls all of the following:
* `redmine-custom::markdown` installs the [Markdown formatter][mdf]

[rm]: http://www.redmine.org/
[rmcb]: https://github.com/juanje/cookbook-redmine
[mdf]: https://github.com/alminium/redmine_redcarpet_formatter
