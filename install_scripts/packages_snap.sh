#!/usr/bin/env bash

echo "<--- installing snap packages... --->"

sudo snap install chromium

# || snaps that need --classic flag.

sudo snap install --classic code
# NOTE: needed for formatting shell scripts
sudo apt install -y shfmt

sudo snap install --classic nvim
# needed for mason's sqlfluff
sudo apt install -y python3.12-venv

sudo apt install -y imagemagick # to see images with snacks.image
# HACK: on older versions, magick is named convert. In latest version, I think it's fixed. Not on ubuntu yet.
# Check later. imagemagick -v 7 should not need this anymore