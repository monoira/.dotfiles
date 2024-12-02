#!/usr/bin/env bash

echo "<--- installing snap packages... --->"

sudo snap install figma-linux
sudo ln -s "$HOME/.local/share/fonts" "$HOME/snap/figma-linux/current/.local/share/"

# snaps that need --classic flag.
sudo snap install --classic nvim

# purging garbage packages on ubuntu
sudo apt purge -y kate
sudo snap remove --purge snap-store
