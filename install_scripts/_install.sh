#!/usr/bin/env bash

# START SCRIPT
bash ~/.dotfiles/install_scripts/0_start_script.sh

# change gnome settings via gsettings
bash ~/.dotfiles/install_scripts/gsettings.sh

# simple automated installations
bash ~/.dotfiles/install_scripts/packages.sh

# complicated automated installations
bash ~/.dotfiles/install_scripts/postgres_and_dbeaver.sh
bash ~/.dotfiles/install_scripts/lazygit.sh
bash ~/.dotfiles/install_scripts/docker.sh
bash ~/.dotfiles/install_scripts/automated_nerd_font.sh
bash ~/.dotfiles/install_scripts/nvm.sh
bash ~/.dotfiles/install_scripts/act.sh
bash ~/.dotfiles/install_scripts/vimv.sh
bash ~/.dotfiles/install_scripts/virt_manager.sh
bash ~/.dotfiles/install_scripts/vscode.sh

# git repositories
bash ~/.dotfiles/install_scripts/dev-clone.sh

# flatpak packages and games
bash ~/.dotfiles/install_scripts/games.sh

# FINISH SCRIPT
bash ~/.dotfiles/install_scripts/1_finish_script.sh
