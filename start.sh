#!/usr/bin/env bash

git clone --recurse-submodules git@github.com:monoira/.dotfiles.git ~/.dotfiles && sh ~/.dotfiles/install.sh && sh ~/.dotfiles/create_symlinks.sh
