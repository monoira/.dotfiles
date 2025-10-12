#!/usr/bin/env bash

# NOTE: setup snippets and settings.json

DOTFILES_DIR="$HOME/.dotfiles"

for profile in ~/.config/Code/User/profiles/*/; do
  snippets_directory="${profile}snippets"
  echo "Updating $snippets_directory"
  rm -rf "$snippets_directory" 2>/dev/null
  if ln -snfT "$DOTFILES_DIR/vscode/snippets" "$snippets_directory"; then
    echo "Linked $snippets_directory -> $DOTFILES_DIR/vscode/snippets"
  else
    echo "Failed to link $snippets_directory"
  fi
done

# -sf for files
ln -sf "$DOTFILES_DIR/vscode/settings.json" ~/.config/Code/User/settings.json
