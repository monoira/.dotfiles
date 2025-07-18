#!/usr/bin/env bash

echo "<--- changing gsettings to customize gnome desktop environment to my taste... --->"

# https://github.com/monoira/slickgnome
wget -qO- https://raw.githubusercontent.com/monoira/slickgnome/main/gnome_settings.sh | bash

# disable "screen locking after period of inactivity"
gsettings set org.gnome.desktop.session idle-delay 0

# turning on "Accessibility > Large Text" automatically
gsettings set org.gnome.desktop.interface text-scaling-factor 1.25
