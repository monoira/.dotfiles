#!/usr/bin/env bash

# || Variables
dotfiles_dir=~/.dotfiles

# NOTE: if you add file or directory here, also add it in uninstall.sh

sh ./uninstall.sh

# single file dotfiles

sudo rm -rf ~/.bashrc >/dev/null 2>&1

sudo rm -rf ~/.zshrc >/dev/null 2>&1

sudo rm -rf ~/.zsh_aliases >/dev/null 2>&1

sudo rm -rf ~/.gitconfig >/dev/null 2>&1

# directories

sudo rm -rf ~/.config/nvim >/dev/null 2>&1

sudo rm -rf ~/.config/alacritty >/dev/null 2>&1

sudo rm -rf ~/.config/tmux >/dev/null 2>&1
