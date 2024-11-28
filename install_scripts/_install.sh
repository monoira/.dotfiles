#!/usr/bin/env bash

bash ~/.dotfiles/install_scripts/flatpak.sh

bash ~/.dotfiles/install_scripts/apt_packages.sh
bash ~/.dotfiles/install_scripts/snap_packages.sh

# complicated automated installations
bash ~/.dotfiles/install_scripts/postgres_and_dbeaver.sh
bash ~/.dotfiles/install_scripts/lazygit.sh
bash ~/.dotfiles/install_scripts/docker_and_lazydocker.sh
bash ~/.dotfiles/install_scripts/automated_nerd_font.sh
bash ~/.dotfiles/install_scripts/vimv.sh
bash ~/.dotfiles/install_scripts/gnome_settings.sh

bash ~/.dotfiles/install_scripts/games.sh

# autoremove packages that are no longer needed
sudo apt autoremove -y
