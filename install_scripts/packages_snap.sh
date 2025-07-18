#!/usr/bin/env bash

echo "<--- installing snap packages... --->"

sudo snap install chromium

# snaps that need --classic flag.
sudo snap install --classic code
sudo snap install --classic nvim
