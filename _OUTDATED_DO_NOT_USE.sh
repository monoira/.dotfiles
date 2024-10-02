#!/usr/bin/env bash

# NOTE: after installing EndeavourOS, run this script first.
# NOTE: you need to have yay and pacman installed for this script to work.

# log failed packages
log_file=~/install_progress_log.txt

# Functions to check if a package is installed
yay_package_installed() {
  if yay -Qi "$1" &>/dev/null; then
    return 0 # Package is installed
  else
    return 1 # Package is not installed
  fi
}

pacman_package_installed() {
  if pacman -Qi "$1" &>/dev/null; then
    return 0 # Package is installed
  else
    return 1 # Package is not installed
  fi
}

# Function to install Yay packages and check installation
install_yay_package_and_check() {
  package_name=$1
  yay -S --noconfirm "$package_name"
  if yay_package_installed "$package_name"; then
    echo "$package_name Installed" >>"$log_file"
  else
    echo "$package_name FAILED TO INSTALL!!!" >>"$log_file"
  fi
}

# Function to install Pacman packages and check installation
install_pacman_package_and_check() {
  package_name=$1
  sudo pacman -S --noconfirm "$package_name"
  if pacman_package_installed "$package_name"; then
    echo "$package_name Installed" >>"$log_file"
  else
    echo "$package_name FAILED TO INSTALL!!!" >>"$log_file"
  fi
}

# not on ubuntu !apt: vimv, lazygit

# | YAY AUR PACKAGES
yay --noconfirm
install_yay_package_and_check visual-studio-code-bin
install_yay_package_and_check figma-linux
install_yay_package_and_check postman-bin
install_yay_package_and_check vimv-git
install_yay_package_and_check rclone-browser

# | PACMAN PACKAGES

# | tools and neovim
# python (it's pip installer that comes with it) and npm are required
# for neovim to download mason packages properly.
# rest are also required for other functionalities inside neovim.
install_pacman_package_and_check python
install_pacman_package_and_check nodejs
install_pacman_package_and_check npm
install_pacman_package_and_check go
install_pacman_package_and_check git
install_pacman_package_and_check lazygit
install_pacman_package_and_check unzip
install_pacman_package_and_check ripgrep
install_pacman_package_and_check fd
install_pacman_package_and_check fzf
install_pacman_package_and_check neovim

# needed for neovim - clipboard for - X11
install_pacman_package_and_check xclip
# needed for neovim - clipboard for - wayland
install_pacman_package_and_check wl-clipboard

# | font, terminal and zsh
install_pacman_package_and_check otf-commit-mono-nerd
install_pacman_package_and_check alacritty
install_pacman_package_and_check zsh
install_pacman_package_and_check zsh-autosuggestions
install_pacman_package_and_check zsh-syntax-highlighting

install_pacman_package_and_check virtualbox
install_pacman_package_and_check virtualbox-ext-vnc

install_pacman_package_and_check fastfetch
install_pacman_package_and_check timeshift
