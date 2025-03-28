#!/usr/bin/env bash

# update apt and snap
sudo apt update -y && sudo apt upgrade -y && sudo snap refresh

# ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
