#!/usr/bin/env bash

# NOTE: cargo required for vimv.
echo "<--- installing vimv... --->"

cargo install vimv
sudo ln -sf ~/.cargo/bin/vimv /bin/vimv
