This directory holds custom VM definitions that you can build with
[VeeWee][vw].

Example
-------
Using the definition in `umts-precise32-omnibus`:

* If you already have a Ubuntu Server 12.04 32-bit ISO downloaded, put
  it in the `iso/` directory.  If not, VeeWee will download it for you.
* `vagrant basebox build umts-precise32-omnibus`  This will build the
  box for you.  When it's done, you'll have a virtual machine in the
  VirtualBox GUI that you can interact with.
* `vagrant package --base umts-precise32-omnibus`  creates a distributable
  .box file for you.
* `vagrant box add umts-precise32-omnibus umts-precise32-omnibus.box`
  adds this box to your store.  Now you can use it in a `Vagrantfile` or
  whatever.


[vw]: https://github.com/jedi4ever/veewee
