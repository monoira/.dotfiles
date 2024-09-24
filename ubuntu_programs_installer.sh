#!/usr/bin/env bash

# NOTE: Font installation

# Create a temporary directory
# TEMP_DIR=$(mktemp -d)
# 
# nerd_font_name="CommitMono"
# 
# nerd_fonts_repo_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$nerd_font_name.zip"
# 
# # Download the font zip file
# wget -O "$TEMP_DIR/font.zip" "$nerd_fonts_repo_url"
# 
# # Unzip the font file
# unzip "$TEMP_DIR/font.zip" -d "$TEMP_DIR"
# 
# # Move the font files to the system fonts directory
# sudo mkdir -p /usr/local/share/fonts/
# sudo mv "$TEMP_DIR"/*.{ttf,otf} /usr/local/share/fonts/
# 
# # Update the font cache
# fc-cache -f -v
# 
# # Clean up
# rm -rf "$TEMP_DIR"

# | temporary snap / apt tutorial
# install with snap / apt - NOTE:sudo snap install package_name
# remove with snap / apt - NOTE:sudo snap remove package_name
# | SNAP ONLY
# see all available updates with snap - NOTE:sudo snap refresh --list
# update with snap - NOTE:sudo snap refresh
# to get information about a single package - NOTE:snap info package_name
# By default, Snap saves one older version of the Snap packages you can go back to the previous one with the revert option - NOTE:sudo snap revert package_name



# more info:
# 1. have to add nerd font manually for now.


# NOTE: apt programs: 
sudo apt install alacritty

sudo apt install fzf
sudo apt install fd-find
sudo apt install ripgrep


sudo apt install xclip wl-clipboard

sudo apt install wl-clipboard


# PPA installs
sudo add-apt-repository ppa:lazygit-team/daily

sudo apt update

sudo apt install lazygit

# zsh installation with it's plugins
sudo apt install zsh

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting



# NOTE: snap programs:
sudo snap install nvim --classic
