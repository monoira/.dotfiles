#!/usr/bin/env bash

# NOTE: Font installation

# Create a temporary directory
TEMP_DIR=$(mktemp -d)

nerd_font_name="CommitMono"

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

# | temporary snap / apt tutorial
# install with snap / apt - NOTE:sudo snap install package_name
# remove with snap / apt - NOTE:sudo snap remove package_name
# | SNAP ONLY
# see all available updates with snap - NOTE:sudo snap refresh --list
# update with snap - NOTE:sudo snap refresh
# to get information about a single package - NOTE:snap info package_name
# By default, Snap saves one older version of the Snap packages you can go back to the previous one with the revert option - NOTE:sudo snap revert package_name

# NOTE: installations
sudo snap install nvim
