Files in this directory are .xml snippets that describe attributes that
will go in the `attribute-map.xml` file.  All files in this directory
with an ".xml" extension will be concatenated together and wrapped in an
`<Attribute>` element in order to build the attribute-map.

This directory is a build with a `remote_directory` resource in the
`shibboleth::default` recipe, but the "purge" option is not set, which
means that you can drop-off attributes here using other cookbooks.  Just
make sure to do the following:

```ruby
notifies :create, 'ruby_block[build-attribute-map]'
```

Otherwise, the built file won't be updated.

On my todo list is to create a LWRP that does all of this for you so
that you won't have to worry about remembering which resources to
notify.
