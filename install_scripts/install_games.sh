#!/usr/bin/env bash

echo "<--- installing games and game launchers... --->"

sudo dnf install -y steam
flatpak install -y --system org.vinegarhq.Sober
