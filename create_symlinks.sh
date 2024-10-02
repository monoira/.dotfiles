#!/usr/bin/env bash

# || Variables
dotfiles_dir=~/.dotfiles

# - First line removes default configurations that stayed after installations of packages.
# >/dev/null thing makes it so that any system responses will be written there.
# - Second line creates symlink between files at .dotfiles and it's regular destination.

# single file dotfiles

sudo rm -rf ~/.bashrc >/dev/null 2>&1
ln -sf $dotfiles_dir/.bashrc ~/.bashrc

sudo rm -rf ~/.zshrc >/dev/null 2>&1
ln -sf $dotfiles_dir/.zshrc ~/.zshrc

sudo rm -rf ~/.bash_aliases >/dev/null 2>&1
ln -sf $dotfiles_dir/.bash_aliases ~/.bash_aliases

sudo rm -rf ~/.gitconfig >/dev/null 2>&1
ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig

# directories

sudo rm -rf ~/.config/nvim >/dev/null 2>&1
ln -sf $dotfiles_dir/nvim ~/.config/nvim

sudo rm -rf ~/.config/alacritty >/dev/null 2>&1
ln -sf $dotfiles_dir/alacritty ~/.config/alacritty

sudo rm -rf ~/.config/tmux >/dev/null 2>&1
ln -sf $dotfiles_dir/tmux ~/.config/tmux
