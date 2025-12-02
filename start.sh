#!/usr/bin/env bash

# TODO: test with this once you buy better pc that can run virtual machine or find other way to test.
# https://www.youtube.com/watch?v=4ygaA_y1wvQ&t=924s

# set -euo pipefail

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
    # HACK: I need to repeat stow twice. First so that if files exist already, those files overwrite
    # this git repo's files, then I reset this repo and run stow again.
    # all this because git stow can't overwrite files / directories if they are already present.

    bash ~/.dotfiles/install_scripts/_install.sh
    cd ~/.dotfiles || exit 1
    stow --verbose --adopt cmus git kitty zsh
    git add . && git reset --hard
    stow --verbose --adopt cmus git kitty zsh
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
