#!/usr/bin/env bash

# DEPENDENCIES
sudo dnf upgrade -y --refresh && flatpak update -y && sudo dnf autoremove -y
sudo dnf install -y stow git wget

# change gnome settings via gsettings
bash ~/.dotfiles/install_scripts/gsettings.sh

# simple automated installations
bash ~/.dotfiles/install_scripts/packages.sh
bash ~/.dotfiles/install_scripts/packages_flatpak.sh

# complicated automated installations
bash ~/.dotfiles/install_scripts/postgres_and_dbeaver.sh
bash ~/.dotfiles/install_scripts/lazygit.sh
bash ~/.dotfiles/install_scripts/docker.sh
bash ~/.dotfiles/install_scripts/automated_nerd_font.sh
bash ~/.dotfiles/install_scripts/nvm.sh
bash ~/.dotfiles/install_scripts/act.sh
bash ~/.dotfiles/install_scripts/vimv.sh
bash ~/.dotfiles/install_scripts/vscode.sh

# git repositories
bash ~/.dotfiles/install_scripts/dev-clone.sh

# flatpak packages and games
bash ~/.dotfiles/install_scripts/games.sh

# finish.
sudo dnf upgrade -y --refresh && flatpak update -y && sudo dnf autoremove -y
