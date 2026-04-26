#!/usr/bin/env bash

echo "<--- installing syncthing and obsidian... --->"

sudo dnf install syncthing -y
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

flatpak install flathub md.obsidian.Obsidian -y
# HACK: for now, obsidian doesn't start fullscreen, so I have to use this to force fullscreen
sudo flatpak override md.obsidian.Obsidian --socket=wayland --env=OBSIDIAN_USE_WAYLAND=1
