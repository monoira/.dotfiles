#!/usr/bin/env bash

# START SCRIPT
bash ~/.dotfiles/install_scripts/0_start_script.sh

# change gnome gsettings
bash ~/.dotfiles/install_scripts/gsettings.sh

# simple automated installations
bash ~/.dotfiles/install_scripts/flatpak.sh

bash ~/.dotfiles/install_scripts/packages_apt.sh
bash ~/.dotfiles/install_scripts/packages_snap.sh
bash ~/.dotfiles/install_scripts/packages_flatpak.sh

# complicated automated installations
bash ~/.dotfiles/install_scripts/postgres_and_dbeaver.sh
bash ~/.dotfiles/install_scripts/lazygit.sh
bash ~/.dotfiles/install_scripts/docker_and_lazydocker.sh
bash ~/.dotfiles/install_scripts/automated_nerd_font.sh
bash ~/.dotfiles/install_scripts/nvm.sh
bash ~/.dotfiles/install_scripts/act.sh
bash ~/.dotfiles/install_scripts/vimv.sh
bash ~/.dotfiles/install_scripts/games.sh

# FINISH SCRIPT
bash ~/.dotfiles/install_scripts/1_finish_script.sh
