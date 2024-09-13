#!/usr/bin/env bash

# || Variables
dotfiles_dir=~/.dotfiles

# || removing default configurations that stayed after installations of packages.
# >/dev/null thing makes it so that any system responses will be written there

sudo rm -rf ~/.bashrc >/dev/null 2>&1
sudo rm -rf ~/.zshrc >/dev/null 2>&1
sudo rm -rf ~/.bash_aliases >/dev/null 2>&1
sudo rm -rf ~/.gitconfig >/dev/null 2>&1

sudo rm -rf ~/.config/nvim >/dev/null 2>&1
sudo rm -rf ~/.config/alacritty >/dev/null 2>&1

# || creating symlinks

ln -sf $dotfiles_dir/.bashrc ~/.bashrc
ln -sf $dotfiles_dir/.zshrc ~/.zshrc
ln -sf $dotfiles_dir/.bash_aliases ~/.bash_aliases
ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig

ln -sf $dotfiles_dir/nvim ~/.config/nvim
ln -sf $dotfiles_dir/alacritty ~/.config/alacritty
