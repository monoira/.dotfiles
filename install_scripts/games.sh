#!/usr/bin/env bash
# NOTE: To ensure compatibility with 32-bit and 64-bit games in Steam’s extensive library, enable 32-bit support.
# ALSO NEEDED FOR HEROIC GAMES LAUNCHER IF NOT USING flatpak version.
sudo dpkg --add-architecture i386 && sudo apt -y update && sudo apt install -y wine64 wine32 libasound2-plugins:i386 libsdl2-2.0-0:i386 libdbus-1-3:i386 libsqlite3-0:i386

echo "<--- installing Heroic Games Launcher... --->"

cd /tmp || exit

# Get the latest release version
HEROIC_VERSION=$(curl -s "https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

# Download the .deb package
curl -sLo "heroic_${HEROIC_VERSION}_amd64.deb" "https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest/download/heroic_${HEROIC_VERSION}_amd64.deb"

# Install the .deb package
sudo dpkg -i "heroic_${HEROIC_VERSION}_amd64.deb"

# Clean up
rm "heroic_${HEROIC_VERSION}_amd64.deb"

# Return to the original directory
cd - || exit

echo "<--- installing steam... --->"
sudo snap install steam

echo "<--- installing sober... --->"
flatpak install --user https://sober.vinegarhq.org/sober.flatpakref
