#!/usr/bin/env bash

# NOTE: setup snippets and settings.json

DOTFILES_DIR="$HOME/.dotfiles"

# -snfT for directories
for profile in ~/.config/Code/User/profiles/*/; do
  snippets_directory="${profile}snippets"
  rm -rf "$snippets_directory"
  ln -snfT "$DOTFILES_DIR/nvim/.config/nvim/snippets" "$snippets_directory"
done

# -sf for files
ln -sf "$DOTFILES_DIR/vscode/settings.json" ~/.config/Code/User/settings.json
