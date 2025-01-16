#!/usr/bin/env bash

echo "<--- installing snap packages... --->"

# HACK: to symlink, figma-linux needs to be ran and generate figma-linux/current/.local/share
sudo snap install figma-linux
if which figma-linux >/dev/null; then
  figma-linux
fi
sudo ln -s "$HOME/.local/share/fonts" "$HOME/snap/figma-linux/current/.local/share/"

sudo snap install chromium

# snaps that need --classic flag.
sudo snap install --classic nvim

# purging garbage packages on ubuntu
sudo snap remove --purge snap-store
