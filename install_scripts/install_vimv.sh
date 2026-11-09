#!/usr/bin/env bash

echo "<--- installing vimv... --->"

# https://github.com/thameera/vimv
mkdir -p "$HOME/.local/bin" &&
curl -fsSL https://raw.githubusercontent.com/thameera/vimv/master/vimv \
  -o "$HOME/.local/bin/vimv" &&
chmod +x "$HOME/.local/bin/vimv"