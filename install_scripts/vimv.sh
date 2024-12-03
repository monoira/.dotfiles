#!/usr/bin/env bash

# NOTE: cargo required for vimv.
echo "<--- installing vimv... --->"

# The --locked flag ensures that Cargo uses the EXACT DEPENDENCY VERSIONS specified in the Cargo.lock file,
# ignoring updates. This ensures reproducible builds.
cargo install vimv --locked
sudo ln -sf ~/.cargo/bin/vimv /bin/vimv
