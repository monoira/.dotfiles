#!/usr/bin/env bash

echo "<--- changing gsettings to customize gnome desktop environment to my taste... --->"

# https://github.com/monoira/slickgn
wget -qO- https://raw.githubusercontent.com/monoira/slickgn/main/gnome_settings.sh | bash
