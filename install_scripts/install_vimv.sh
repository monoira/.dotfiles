#!/usr/bin/env bash

# NOTE: cargo required for vimv.
echo "<--- installing vimv... --->"

# https://github.com/thameera/vimv
curl https://raw.githubusercontent.com/thameera/vimv/master/vimv >~/.local/bin/vimv && chmod +755 ~/.local/bin/vimv
