#!/usr/bin/env bash

echo "<--- installing flatpak packages... --->"

flatpak install -y --system flathub no.mifi.losslesscut
flatpak install -y --system flathub org.kde.kdenlive

flatpak install -y --system flathub com.discordapp.Discord
flatpak install -y --system flathub hu.irl.cameractrls

flatpak install -y --system flathub io.dbeaver.DBeaverCommunity
