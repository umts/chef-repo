This directory contains some miscellaneous utility scripts.  Safe to
ignore, but here for your convenience.

`aliases.sh`
------------
A collection of helpful aliases.  You could put them in your
`.rvmrc.local` file or in your `.bash_profile` file or whatever.  Or, if
you like all of them, you can just add

```bash
source util/aliases.sh
```

`run-chef.sh`
-------------
This script can be put on a chef client (any machine that has
"chef-client" running in daemon mode on it) and it can be used to
trigger a chef run _now_ and it will tail the log output to the terminal
until the run finishes.

I haven't figured out a way to run it without first uploading the file
to the client, however.
