#!/usr/bin/env bash

required_packages=(
  bash
  git
  stow
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

  git clone --recurse-submodules git@github.com:monoira/.dotfiles.git ~/.dotfiles &&
    bash ~/.dotfiles/install.sh &&
    stow -v --adopt alacritty cmus git nvim sqlfluff tmux zsh

else
  echo "<--- ONE OR MORE OF THE REQUIRED PACKAGE ARE NOT INSTALLED!!! --->"
  echo "<--- The required packages are: --->"

  # checks each package individually to see which packages are not installed and echos them out
  for req_pkg in "${required_packages[@]}"; do
    if [ "$(which "$req_pkg")" ]; then
      echo "$req_pkg - Status: Installed."
    else
      echo "$req_pkg - Status: NOT INSTALLED!!!"
    fi
  done

fi
