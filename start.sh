#!/usr/bin/env bash

# TODO: test with this once you buy better pc that can run virtual machine or find other way to test.
# https://youtu.be/4ygaA_y1wvQ?t=924

# set -euo pipefail

required_packages=(
  bash
  snap
  gnome-shell
  wget
  stow
  git
)

all_required_packages_are_installed=true

for req_pkg in "${required_packages[@]}"; do
  if [ -z "$(which "$req_pkg")" ]; then
    all_required_packages_are_installed=false
    break
  fi
done

if $all_required_packages_are_installed; then
  echo "<--- All required packages are installed. --->"
  echo "<--- Starting installation... --->"

  # HACK: I need to repeat stow twice. First so that if files exist already, those files overwrite
  # this git repo's files, then I reset this repo and run stow again.
  # all this because git stow can't overwrite files / directories if they are already present
  git clone --recurse-submodules git@github.com:monoira/.dotfiles.git ~/.dotfiles &&
    bash ~/.dotfiles/install_scripts/_install.sh &&
    cd ~/.dotfiles &&
    stow --verbose --adopt alacritty cmus git nvim sqlfluff tmux zsh &&
    git add . && git reset --hard &&
    stow --verbose --adopt alacritty cmus git nvim sqlfluff tmux zsh

else
  echo "<--- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --->"
  echo "<--- ONE OR MORE OF THE REQUIRED PACKAGE ARE NOT INSTALLED!!! --->"
  echo "<--- The required packages are: --->"

  # checks each package individually to see which packages
  # are not installed and echos them out if they are not installed
  for req_pkg in "${required_packages[@]}"; do
    if [ "$(which "$req_pkg")" ]; then
      echo "<--- $req_pkg - Status: Installed. --->"
    else
      echo "<--- $req_pkg - Status: NOT INSTALLED!!! --->"
    fi
  done

fi
