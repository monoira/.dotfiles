#!/usr/bin/env bash

echo "<--- installing flatpak... --->"
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
