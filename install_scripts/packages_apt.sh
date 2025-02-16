#!/usr/bin/env bash

echo "<--- installing apt packages... --->"

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y curl       # for lasygit AND lazydocker
sudo apt install -y wget       # for dbeaver AND install_nerd_font()
sudo apt install -y fontconfig # for install_nerd_font()
sudo apt install -y build-essential
# The add-apt-repository utility is included in the software-properties-common
sudo apt install -y software-properties-common
sudo apt install -y git
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y golang
sudo apt install -y cargo
sudo apt install -y luarocks
sudo apt install -y nodejs
sudo apt install -y npm

sudo apt install -y kitty
sudo apt install -y imagemagick # to see images in kitty
sudo apt install -y tmux

# packages needed for neovim
sudo apt install -y fzf
sudo apt install -y fd-find
sudo apt install -y ripgrep

# clipboard for - x11
sudo apt install -y xclip
# clipboard for - wayland
sudo apt install -y wl-clipboard

# needed for mason's sqlfluff
sudo apt install -y python3.12-venv

# general use packages
sudo apt install -y screenfetch
sudo apt install -y cmatrix
sudo apt install -y btop
sudo apt install -y libreoffice
sudo apt install -y vlc
sudo apt install -y shotwell

sudo apt install -y timeshift
sudo apt install -y qbittorrent
sudo apt install -y cmus
sudo apt install -y rclone
sudo apt install -y rclone-browser
