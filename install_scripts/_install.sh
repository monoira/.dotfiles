#!/usr/bin/env bash

# dependencies
sudo dnf upgrade -y --refresh && flatpak update -y
sudo dnf install -y stow git wget

# change gnome settings via gsettings
bash ~/.dotfiles/install_scripts/set_gsettings.sh

# simple automated installations
bash ~/.dotfiles/install_scripts/packages.sh
bash ~/.dotfiles/install_scripts/packages_flatpak.sh

# complicated automated installations
bash ~/.dotfiles/install_scripts/install_nerd_font.sh
bash ~/.dotfiles/install_scripts/install_lazygit.sh
bash ~/.dotfiles/install_scripts/install_docker.sh
bash ~/.dotfiles/install_scripts/install_nvm.sh
bash ~/.dotfiles/install_scripts/install_act.sh
bash ~/.dotfiles/install_scripts/install_vimv.sh
bash ~/.dotfiles/install_scripts/install_vscode.sh
bash ~/.dotfiles/install_scripts/install_postgres_and_dbeaver.sh
bash ~/.dotfiles/install_scripts/install_obsidian_and_syncthing.sh

# flatpak packages and games
bash ~/.dotfiles/install_scripts/install_games.sh

# clone git repositories
bash ~/.dotfiles/install_scripts/dev-clone.sh

# finish
sudo dnf upgrade -y --refresh && flatpak update -y && sudo dnf autoremove -y
