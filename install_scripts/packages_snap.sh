#!/usr/bin/env bash

echo "<--- installing snap packages... --->"

sudo snap install chromium

# || snaps that need --classic flag.

sudo snap install --classic code
# NOTE: needed for formatting and checking shell scripts and their extensions
sudo apt install -y shfmt
sudo apt install -y shellcheck
# NOTE: needed for markdown lint extension to work
sudo apt install -y markdownlint

sudo snap install --classic nvim
# needed for mason's sqlfluff
sudo apt install -y python3.12-venv
