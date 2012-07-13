This directory is for cookbooks that for whatever reason don't belong
elsewhere (e.g. their own git repository).  Consider whether that is the
case before adding a cookbook here.

In a "normal" Chef repository, this directory would be in the
`cookbook_path` and you could use Knife to upload cookbboks from here
the same way as with `cookbooks/`.  In our repository, that is not the
case.  If you add a cookbook here, add it to the `Cheffile` with a
"path" argument, like this"

```ruby
cookbook "some_cookbook",
  :path => site-cookbooks/some_cookbook"
```
