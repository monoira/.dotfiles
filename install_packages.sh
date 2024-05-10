#!/bin/bash

# NOTE: after installing EndeavourOS, run this script first.

# failure log script in case installation of some packages fail
log_file=~/install_progress_log.txt

# Function to check if a package is installed
package_installed() {
	if command -v "$1" &>/dev/null; then
		return 0 # Package is installed
	else
		return 1 # Package is not installed
	fi
}

# Function to install Yay packages and check installation
install_yay_package_and_check() {
	package_name=$1
	yay -S --noconfirm "$package_name"
	if package_installed "$package_name"; then
		echo "$package_name Installed" >>"$log_file"
	else
		echo "$package_name FAILED TO INSTALL!!!" >>"$log_file"
	fi
}

# Function to install Pacman packages and check installation
install_pacman_package_and_check() {
	package_name=$1
	sudo pacman -S --noconfirm "$package_name"
	if package_installed "$package_name"; then
		echo "$package_name Installed" >>"$log_file"
	else
		echo "$package_name FAILED TO INSTALL!!!" >>"$log_file"
	fi
}

# YAY AUR PACKAGES
yay --noconfirm
install_yay_package_and_check visual-studio-code-bin
install_yay_package_and_check figma-linux
install_yay_package_and_check postman-bin

# PACMAN PACKAGES
install_pacman_package_and_check zsh

install_pacman_package_and_check timeshift
install_pacman_package_and_check nodejs
install_pacman_package_and_check npm
install_pacman_package_and_check git
install_pacman_package_and_check lazygit

install_pacman_package_and_check xclip
install_pacman_package_and_check ripgrep
install_pacman_package_and_check fd
install_pacman_package_and_check fzf
install_pacman_package_and_check ffmpegthumbs
install_pacman_package_and_check neovim
install_pacman_package_and_check otf-commit-mono-nerd
install_pacman_package_and_check wezterm

install_pacman_package_and_check fastfetch
