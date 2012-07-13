Introduction
============
This directory is for cookbooks that for whatever reason don't belong
elsewhere (e.g. their own git repository).  Consider whether that is the
case before adding a cookbook here.

The Cookbook Path
=================
In a "normal" Chef repository, this directory would be in the
`cookbook_path` and you could use Knife to upload cookbboks from here
the same way as with `cookbooks/`.  In our repository, that is not the
case.  If you add a cookbook here, add it to the `Cheffile` with a
"path" argument, like this"

```ruby
cookbook "some_cookbook",
  :path => site-cookbooks/some_cookbook"
```

Moving Up, Moving Out
=====================
When a site-cookbook is mature enough to deserve its own repository, you
can use the `extract-cookbook` script in this directory to export a
cookbook to a repository outside of the chef repository.  Here's how you
would use it to pull out a cookbook called "myapp"

1.  Make sure that all changes to the `site-cookbooks/myapp/` directory
    are committed and that you are on the "master" branch.

2.  Run the `extract-cookbook` command
    ```bash
    $ site-cookbooks/extract-cookbook myapp
    ```

3.  There will be a new repository in the same directory as your chef
    repository called `chef-myapp`  Make sure everything looks
    satisfactory there.

4.  Add a remote to the new repository and push it to the server

5.  Modify the `Cheffile` to point to the new git location instead of
    the path, and run `librarian-chef install`

6.  Remove the directory in `site-cookbooks/` from git, and commit your
    changes.
