#!/usr/bin/env bash

# NOTE: Font installation

# Create a temporary directory
TEMP_DIR=$(mktemp -d)

nerd_font_name="FiraCode"

nerd_fonts_repo_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$nerd_font_name.zip"

# Download the font zip file
wget -O "$TEMP_DIR/font.zip" "$nerd_fonts_repo_url"

# Unzip the font file
unzip "$TEMP_DIR/font.zip" -d "$TEMP_DIR"

# Move the font files to the system fonts directory
sudo mkdir -p /usr/local/share/fonts/
sudo mv "$TEMP_DIR"/*.{ttf,otf} /usr/local/share/fonts/

# Update the font cache
fc-cache -f -v

# Clean up
rm -rf "$TEMP_DIR"

# NOTE: installations
# sudo apt install snapd
