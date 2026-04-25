#!/usr/bin/env bash

echo "<--- installing games and game launchers... --->"

sudo dnf install -y steam
flatpak install -y com.heroicgameslauncher.hgl
flatpak install -y org.vinegarhq.Sober
