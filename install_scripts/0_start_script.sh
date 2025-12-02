#!/usr/bin/env bash

# update packages
sudo dnf upgrade -y --refresh && flatpak update -y && sudo dnf autoremove -y

# ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
