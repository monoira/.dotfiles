#!/usr/bin/env bash

# revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true

# update everything and autoremove unnecessary packages
sudo dnf upgrade -y --refresh && flatpak update -y && sudo dnf autoremove -y
