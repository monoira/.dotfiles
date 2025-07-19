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
