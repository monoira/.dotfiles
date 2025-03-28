#!/usr/bin/env bash

# revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true

# update everything and autoremove unnecessary apt packages
sudo apt update -y && sudo apt upgrade -y && sudo snap refresh && flatpak update -y && sudo apt autoremove -y
