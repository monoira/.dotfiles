#!/usr/bin/env bash

echo "<--- installing packages ... --->"
sudo dnf upgrade -y --refresh

# basics
sudo dnf install -y git
sudo dnf install -y curl
sudo dnf install -y wget
sudo dnf install -y fontconfig # for github.com/monoira/nefoin

# programming languages & tools
sudo dnf install -y nodejs
sudo dnf install -y nodejs-npm
sudo dnf install -y python3
sudo dnf install -y python3-pip
sudo dnf install -y golang
sudo dnf install -y rust
sudo dnf install -y cargo

# terminal
sudo dnf install -y kitty
sudo dnf install -y neovim

# chromium for testing outside of firefox
sudo dnf install -y chromium

# packages for CLI
sudo dnf install -y fzf
sudo dnf install -y fd-find
sudo dnf install -y ripgrep

# clipboard
sudo dnf install -y xclip
sudo dnf install -y wl-clipboard # for Wayland

# general packages
sudo dnf install -y fastfetch
sudo dnf install -y cmatrix
sudo dnf install -y btop
sudo dnf install -y shotwell

sudo dnf install -y qbittorrent
sudo dnf install -y rclone
sudo dnf install -y rclone-browser
sudo dnf install -y obs-studio
