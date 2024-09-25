#!/usr/bin/env bash

# NOTE: after installing Ubuntu, run this script first.
# NOTE: you need to have snap and apt installed for this script to work.

# log failed packages
log_file=~/install_progress_log.txt

# Functions to check if a package is installed
snap_package_installed() {
    if snap list "$1" &>/dev/null; then
        return 0 # Package is installed
    else
        return 1 # Package is not installed
    fi
}

apt_package_installed() {
    if dpkg -s "$1" &>/dev/null; then
        return 0 # Package is installed
    else
        return 1 # Package is not installed
    fi
}

# Function to install Snap packages and check installation
install_snap_package_and_check() {
    package_name=$1
    sudo snap install "$package_name"
    if snap_package_installed "$package_name"; then
        echo "$package_name Installed" >>"$log_file"
    else
        echo "$package_name FAILED TO INSTALL!!!" >>"$log_file"
    fi
}

# Function to install Apt packages and check installation
install_apt_package_and_check() {
    package_name=$1
    sudo sudo apt install -y "$package_name"
    if apt_package_installed "$package_name"; then
        echo "$package_name Installed" >>"$log_file"
    else
        echo "$package_name FAILED TO INSTALL!!!" >>"$log_file"
    fi
}

# | SNAP PACKAGES
install_snap_package_and_check visual-studio-code
install_snap_package_and_check figma
install_snap_package_and_check postman
install_snap_package_and_check rclone-browser

# | APT PACKAGES

# | tools and neovim
# python (it's pip installer that comes with it) and npm are required
# for neovim to download mason packages properly.
# rest are also required for other functionalities inside neovim.
install_apt_package_and_check python3
install_apt_package_and_check nodejs
install_apt_package_and_check npm
install_apt_package_and_check golang
install_apt_package_and_check git
install_apt_package_and_check lazygit
install_apt_package_and_check unzip
install_apt_package_and_check ripgrep
install_apt_package_and_check fd
install_apt_package_and_check fzf
install_apt_package_and_check neovim

# needed for neovim - clipboard for - X11
install_apt_package_and_check xclip
# needed for neovim - clipboard for - wayland
install_apt_package_and_check wl-clipboard

# | font, terminal and zsh
install_apt_package_and_check alacritty

install_apt_package_and_check virtualbox
install_apt_package_and_check virtualbox-ext-pack

install_apt_package_and_check fastfetch
install_apt_package_and_check timeshift





# installing oh-my-zsh resets shell so it must be done at the last.
sudo apt install zsh

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

