#!/usr/bin/env bash

# starting updates
sudo apt update -y && sudo apt upgrade -y && sudo snap refresh

# gnome styling gsettings
bash ~/.dotfiles/install_scripts/gnome_settings.sh

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
bash ~/.dotfiles/install_scripts/vimv.sh
bash ~/.dotfiles/install_scripts/games.sh

# finishing script
bash ~/.dotfiles/install_scripts/finishing_script.sh
