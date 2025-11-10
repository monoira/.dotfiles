#!/usr/bin/env bash

set -euo pipefail

mkdir -p "$HOME/dev"
cd "$HOME/dev" || exit
git clone git@github.com:monoira/general.git
git clone git@github.com:monoira/projects.git
git clone git@github.com:monoira/VSCLazy.git
git clone git@github.com:monoira/interesting.git
git clone git@github.com:monoira/slickgnome.git
git clone git@github.com:monoira/extracton.git
git clone git@github.com:monoira/nefoin.git
git clone git@github.com:monoira/kitty-tabs.git
cd -
