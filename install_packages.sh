#!/bin/bash

# NOTE: after installing EndeavourOS, run this script first.

# failure log script in case installation of some packages fail
log_file=~/install_progress_log.txt

# installation scripts. if it fails, failure will be echoed to log_file
install_pacman_packages_and_check() {
	package_name=$1
	sudo pacman -S --noconfirm $package_name
	if type -p $package_name >/dev/null; then
		echo "$package_name Installed" >>$log_file
	else
		echo "$package_name FAILED TO INSTALL!!!" >>$log_file
	fi
}

install_yay_packages_and_check() {
	package_name=$1
	yay -S --noconfirm $package_name
	if type -p $package_name >/dev/null; then
		echo "$package_name Installed" >>$log_file
	else
		echo "$package_name FAILED TO INSTALL!!!" >>$log_file
	fi
}

# PACMAN PACKAGES

install_pacman_packages_and_check zsh
install_pacman_packages_and_check zsh-syntax-highlighting

install_pacman_packages_and_check timeshift
install_pacman_packages_and_check nodejs
install_pacman_packages_and_check npm
install_pacman_packages_and_check git
install_pacman_packages_and_check lazygit

install_pacman_packages_and_check nuget
install_pacman_packages_and_check dotnet-sdk
install_pacman_packages_and_check aspnet-runtime

install_pacman_packages_and_check xclip
install_pacman_packages_and_check ripgrep
install_pacman_packages_and_check fd
install_pacman_packages_and_check ffmpegthumbs
install_pacman_packages_and_check neovim
install_pacman_packages_and_check otf-commit-mono-nerd
install_pacman_packages_and_check wezterm

# YAY AUR PACKAGES

install_yay_packages_and_check visual-studio-code-bin
install_yay_packages_and_check figma-linux
