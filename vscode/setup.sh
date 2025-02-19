#!/usr/bin/env bash

# NOTE: setup snippets and settings.json

# -snfT for directories
for profile in ~/.config/Code/User/profiles/*/; do
  snippets_directory="${profile}snippets"
  rm -rf "$snippets_directory"
  ln -snfT ~/.dotfiles/nvim/.config/nvim/snippets "$snippets_directory"
done

# -sf for files
ln -sf ~/.dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
