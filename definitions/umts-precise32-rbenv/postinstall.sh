# postinstall.sh created from Mitchell's official lucid32/64 baseboxes

date > /etc/vagrant_box_build_time

# Apt-install various things necessary for Ruby, guest additions,
# etc., and remove optional things to trim down the machine.
apt-get -y update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev
apt-get -y install vim curl git-core
apt-get clean

# Setup sudo to allow no-password sudo for "admin"
groupadd -r admin
usermod -a -G admin vagrant
cp /etc/sudoers /etc/sudoers.orig
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# Install NFS client
apt-get -y install nfs-common

# Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# RBENV
git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
cat > /etc/profile.d/rbenv.sh <<EOF
# prefer a user rbenv over a system wide install
if [ -s "\${HOME}/.rbenv/bin" ]; then
  rbenv_root="\${HOME}/.rbenv"
elif [ -s "/usr/local/rbenv" ]; then
  rbenv_root="/usr/local/rbenv"
  export RBENV_ROOT="\$rbenv_root"
fi

if [ -n "\$rbenv_root" ]; then
  export PATH="\${rbenv_root}/bin:\$PATH"
  eval "\$(rbenv init -)"
fi
EOF
chmod +x /etc/profile.d/rbenv.sh
mkdir -p /usr/local/rbenv/{shims,versions}
export PATH=/usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH
export RBENV_ROOT=/usr/local/rbenv
rbenv rehash 2>/dev/null


# Install ruby-build
git clone git://github.com/sstephenson/ruby-build.git /tmp/ruby-build
cd /tmp/ruby-build
sh ./install.sh

# Install ruby 1.9.3
rbenv install 1.9.3-p194
rbenv global 1.9.3-p194
rbenv rehash

# Chef and puppet
gem install chef --no-ri --no-rdoc
gem install puppet --no-ri --no-rdoc
rbenv rehash

# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

rm VBoxGuestAdditions_$VBOX_VERSION.iso

# Remove items used for building, since they aren't needed anymore
apt-get -y remove linux-headers-$(uname -r) build-essential
apt-get -y autoremove

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

# Make sure Udev doesn't block our network
# http://6.ptmc.org/?p=164
echo "cleaning up udev rules"
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces
exit
