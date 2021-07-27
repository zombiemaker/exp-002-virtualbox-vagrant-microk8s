#!/bin/bash
# Run this from within the VirtualBox VM that you want to create a Vagrant box image




curl http://download.virtualbox.org/virtualbox/6.1.22/VBoxGuestAdditions_6.1.22.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_6.1.22.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_6.1.22.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions