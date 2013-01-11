Description
===========
This cookbook installs and configures a simple [Shibboleth][shib] service
provider.  There's a lot of configuration that isn't covered by this
cookbook, but it does handle the common case of setting up single
sign-on for a web app running on a node.

Requirements
============
The cookbook has only been run on Ubuntu, and will probably need some
adjustment to work on any other platforms.  This cookbook also
requires the [Apache cookbook][apache] in order to handle the enabling
of the Apache module.  It is possible to be using Shibboleth without
Apache, but doing so is complicated and definitely not the most
prevelent use case.

Attributes
==========
* `node['shibboleth']['idp']` - The base URL of your IdP.  This defaults to
  "https://idp.testshib.org" which is the [TestShib][testshib] IdP
* `node['shibboleth']['remote_user']` - A space-seperated string made up
  of attributes to try using to populate the special `REMOTE_USER`
  environment variable.  The default is "eppn persistent-id targeted-id"

[Sessions][sessions]
--------------------
* `node['shibboleth']['sessions']['lifetime']` - The maximum age a
  session can be, regardless of activity, in seconds.  The default is 28800
* `node['shibboleth']['sessions']['timeout']` - The amount of time
  before a session times out due to inactivity in seconds.  The default
  is 3600
* `node['shibboleth']['sessions']['check_address']` - Should the SP
  verify the IP address that the IdP sends back with the authentication
  response?  Defaults to "false".  "True" might help prevent session
  stealing, but can can cause hard-to diagnose errors.
* `node['shibboleth']['sessions']['handler_ssl']` - Force the SP
  handlers to use SSL (other requests are ignored).  Defaults to "true"

Handlers
--------------------
All of these attributes are booleans that declare whether various SP
[handlers][handlers] are enabled.  By default, all of them are set to
"true"

* `node['shibboleth']['handlers']['metadata_generator']`
* `node['shibboleth']['handlers']['status']`
* `node['shibboleth']['handlers']['session']`
* `node['shibboleth']['handlers']['discovery_feed']`

Error pages
-----------
These attributes control the values used on the internal Shibboleth
error pages.

* `node['shibboleth']['errors']['contact']` - A support email address.
  Defaults to "root@#{node['fqdn']}"
* `node['shibboleth']['errors']['logo']` - URL for a logo to display.
  The default is '/shibboleth-sp/logo.jpg', but you'll have to do a bit
  more setup to get that to work.  On Ubuntu, the default logo can be
  found at `/usr/share/shobboleth/` but that location isn't
  web-accessible by default.
* `node['shibboleth']['errors']['css']` - URL for a custom CSS file to
  modify the error pages.  The default is '/shibboleth-sp/main.css', and
  the same deal here as with the logo.

Usage
=====
Shibboleth looks up the attributes that it receives from the IdP using an
[attribute extractor][attributex].  By default that attribute extractor
is the XML file `/etc/shibboleth/attribute-map.xml`.  In order to make
it easier to add additional attributes, this cookbook assembles that
file out of XML fragments that are kept in
`/etc/shibboleth/attributes.d`  There are a number of these fragments in
the `files` directory of this cookbook.

If you want to add additional attribute fragments, you can use Chef to
drop them off, but you have to notify the ruby block resource that
builds the `attribute-map.xml` file like so:

```ruby
cookbook_file '/etc/shibboleth/attributes.d/my_attribute.xml' do
  mode '0644'
  notifies :create, 'ruby_block[build-attribute-map]'
end
```

On the to-do list is to write a LWRP that handles the attribute file
creation and notification for you.

[shib]: http://shibboleth.net/
[apache]: http://community.opscode.com/cookbooks/apache2
[sessions]: https://wiki.shibboleth.net/confluence/display/SHIB2/NativeSPSessions
[handlers]: https://wiki.shibboleth.net/confluence/display/SHIB2/NativeSPHandler
[attributex]: https://wiki.shibboleth.net/confluence/display/SHIB2/NativeSPAttributeExtractor
