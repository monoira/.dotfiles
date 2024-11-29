#!/usr/bin/env bash
# NOTE: To ensure compatibility with 32-bit and 64-bit games in Steam’s extensive library, enable 32-bit support.
# Lower-end systems, which often run 32-bit games, particularly benefit from this support.
# Meanwhile, high-powered systems experience no negative impact from installing additional packages.
# To enable 32-bit support on your Ubuntu system, run the following command:
sudo dpkg --add-architecture i386

echo "<--- installing Heroic Games Launcher... --->"
cd /tmp

# Get the latest release version
HEROIC_VERSION=$(curl -s "https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

# Download the .deb package
curl -sLo "heroic_${HEROIC_VERSION}_amd64.deb" "https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest/download/heroic_${HEROIC_VERSION}_amd64.deb"

# Check if the .deb file was downloaded successfully
if [ ! -f "heroic_${HEROIC_VERSION}_amd64.deb" ]; then
  echo "Error: Failed to download the .deb file."
  exit 1
fi

# Install the .deb package
sudo dpkg -i "heroic_${HEROIC_VERSION}_amd64.deb"

# Clean up
rm "heroic_${HEROIC_VERSION}_amd64.deb"

# Return to the original directory
cd -

echo "<--- installing Steam... --->"
# sudo snap install steam
