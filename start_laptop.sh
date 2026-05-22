#!/usr/bin/env bash

set -euo pipefail

run_script() {
	echo "<--- Running $1... --->"
	if bash "$1"; then
		echo "<--- FINISHED $1. --->"
	else
		echo "<--- FAILED $1. Stopping. --->"
		exit 1
	fi
}

echo "<--- Starting installation... --->"
git clone --recurse-submodules git@github.com:monoira/.dotfiles.git ~/.dotfiles || true

# dependencies
sudo dnf upgrade -y --refresh && flatpak update -y
sudo dnf install -y stow git wget

# change gnome settings via gsettings
run_script ~/.dotfiles/install_scripts/set_gsettings.sh

# simple automated installations
run_script ~/.dotfiles/install_scripts/packages.sh
run_script ~/.dotfiles/install_scripts/packages_flatpak.sh

# complicated automated installations
run_script ~/.dotfiles/install_scripts/install_nerd_font.sh
run_script ~/.dotfiles/install_scripts/install_lazygit.sh
run_script ~/.dotfiles/install_scripts/install_docker.sh
run_script ~/.dotfiles/install_scripts/install_nvm.sh
run_script ~/.dotfiles/install_scripts/install_act.sh
run_script ~/.dotfiles/install_scripts/install_opencode.sh
run_script ~/.dotfiles/install_scripts/install_cmus.sh
run_script ~/.dotfiles/install_scripts/install_vimv.sh
run_script ~/.dotfiles/install_scripts/install_vscode.sh
run_script ~/.dotfiles/install_scripts/install_postgres_and_dbeaver.sh
run_script ~/.dotfiles/install_scripts/install_obsidian_and_syncthing.sh

# clone git repositories
run_script ~/.dotfiles/install_scripts/dev-clone.sh

# finish
sudo dnf upgrade -y --refresh && flatpak update -y && sudo dnf autoremove -y

cd ~/.dotfiles || exit 1
echo "<--- CD'd into ~/.dotfiles, time to stow adopt... --->"

# HACK: I need to repeat stow twice. First so that if files exist already, those files overwrite
# this git repo's files, then I reset this repo and run stow again.
# all this because git stow can't overwrite files / directories if they are already present.
stow --verbose --adopt cmus git kitty tmux zsh nvim opencode .agents
git add . && git reset --hard
stow --verbose --adopt cmus git kitty tmux zsh nvim opencode .agents

echo "<--- installation finished. --->"
