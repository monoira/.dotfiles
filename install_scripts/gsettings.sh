#!/usr/bin/env bash

echo "<--- changing gsettings to customize gnome desktop environment to my taste... --->"

# https://github.com/monoira/slickgnome
wget -qO- https://raw.githubusercontent.com/monoira/slickgnome/main/gnome_settings.sh | bash
