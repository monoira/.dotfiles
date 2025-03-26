#!/usr/bin/env bash

echo "<--- installing KVM, virt-manager, their dependencies and setting them up... --->"

sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
sudo adduser "$USER" libvirt
sudo adduser "$USER" kvm
