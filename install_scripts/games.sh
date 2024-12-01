#!/usr/bin/env bash
# NOTE: To ensure compatibility with 32-bit and 64-bit games in Steam’s extensive library, enable 32-bit support.
# Lower-end systems, which often run 32-bit games, particularly benefit from this support.
# Meanwhile, high-powered systems experience no negative impact from installing additional packages.
# To enable 32-bit support on your Ubuntu system, run the following command:
sudo dpkg --add-architecture i386 && sudo apt -y update && sudo apt -y upgrade

echo "<--- installing lutris... --->"
sudo apt install -y lutris

echo "<--- installing Steam... --->"
wget -O - http://repo.steampowered.com/steam/archive/precise/steam.gpg | sudo apt-key add -
sudo sh -c 'echo "deb http://repo.steampowered.com/steam/ stable steam" >> /etc/apt/sources.list.d/steam.list'
sudo apt update -y
sudo apt install -y steam-launcher

# HACK: for nvidia drivers
# sudo apt install -y nvidia-driver-515
