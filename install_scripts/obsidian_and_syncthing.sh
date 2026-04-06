#!/usr/bin/env bash

sudo dnf install syncthing -y
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
flatpak install flathub md.obsidian.Obsidian -y
