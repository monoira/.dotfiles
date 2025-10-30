#!/usr/bin/env bash

echo "<--- Installing KVM, virt-manager, dependencies and setting up... --->"

sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

# start & enable libvirt daemon
sudo systemctl enable --now libvirtd

# add current user to groups
sudo adduser "$USER" libvirt
sudo adduser "$USER" kvm
