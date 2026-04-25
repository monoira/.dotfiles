#!/usr/bin/env bash

set -euo pipefail

dependency_packages=(
  bash
  gnome-shell
  wget
  stow
  git
)

all_dependency_packages_are_installed=true
for dep_pkg in "${dependency_packages[@]}"; do
  if ! command -v "$dep_pkg" &>/dev/null; then
    all_dependency_packages_are_installed=false
  fi
done

if $all_dependency_packages_are_installed; then
  echo "<--- All dependency packages are installed. --->"
  echo "<--- Starting installation... --->"

  install_and_stow() {
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

    # clone git repositories
    bash ~/.dotfiles/install_scripts/dev-clone.sh

    # finish
    sudo dnf upgrade -y --refresh && flatpak update -y && sudo dnf autoremove -y

    cd ~/.dotfiles || exit 1
    # HACK: I need to repeat stow twice. First so that if files exist already, those files overwrite
    # this git repo's files, then I reset this repo and run stow again.
    # all this because git stow can't overwrite files / directories if they are already present.
    stow --verbose --adopt cmus git kitty zsh nvim
    git add . && git reset --hard
    stow --verbose --adopt cmus git kitty zsh nvim
  }

  echo "<--- cloning using SSH... --->"
  git clone --recurse-submodules git@github.com:monoira/.dotfiles.git ~/.dotfiles &&
    install_and_stow

else
  echo "<--- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --->"
  echo "<--- ONE OR MORE OF THE REQUIRED DEPENDENCY PACKAGES ARE NOT INSTALLED!!! --->"
  echo "<--- The dependency packages are: --->"

  # checks each package individually to see which packages
  # are not installed and echos them out if they are not installed
  for dep_pkg in "${dependency_packages[@]}"; do
    if command -v "$dep_pkg" &>/dev/null; then
      echo "<--- $dep_pkg - Status: Installed. --->"
    else
      echo "<--- $dep_pkg - Status: NOT INSTALLED!!! --->"
    fi
  done
  exit 1
fi
