#!/usr/bin/env bash
echo "<--- installing steam... --->"
sudo snap install steam

echo "<--- installing Heroic... --->"
flatpak install -y --user com.heroicgameslauncher.hgl

echo "<--- installing sober... --->"
flatpak install -y --user https://sober.vinegarhq.org/sober.flatpakref
