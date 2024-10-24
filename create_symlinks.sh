#!/usr/bin/env bash

# || Variables
dotfiles_dir=~/.dotfiles

# NOTE: if you add file or directory here, also add it in uninstall.sh in case of uninstallation

sh ./uninstall.sh

# single file dotfiles

ln -sf $dotfiles_dir/zsh/.bashrc ~/.bashrc

ln -sf $dotfiles_dir/zsh/.zshrc ~/.zshrc

ln -sf $dotfiles_dir/zsh/.zsh_aliases ~/.zsh_aliases

ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig

# directories

ln -sf $dotfiles_dir/nvim ~/.config/nvim

ln -sf $dotfiles_dir/alacritty ~/.config/alacritty

ln -sf $dotfiles_dir/tmux ~/.config/tmux

echo "<--- SYMLINKS HAVE BEEN SET. SCRIPTS ARE FINISHED. --->"
