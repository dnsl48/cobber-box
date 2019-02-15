#!/bin/bash

# Do not override if it's already pre-existing filesystem
if [[ $(btrfs-find-root /dev/sdb) != "0" ]]; then
    mkfs.btrfs -L bench /dev/sdb;
fi;

mkdir -p /home/vagrant/bench
chown vagrant:vagrant /home/vagrant/bench
mount -o compress=lzo /dev/sdb /home/vagrant/bench
chown vagrant:vagrant /home/vagrant/bench

echo "/dev/sdb  /home/vagrant/bench  btrfs  rw,relatime,compress=lzo,ssd,space_cache  0 0" >> /etc/fstab
