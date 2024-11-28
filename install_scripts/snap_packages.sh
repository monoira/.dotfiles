#!/usr/bin/env bash

echo "<--- installing snap packages... --->"

sudo snap install figma-linux
sudo snap install postman

# snaps that need --classic flag.
sudo snap install --classic nvim

# purging garbage packages on ubuntu
sudo apt purge -y kate
sudo snap remove --purge snap-store
