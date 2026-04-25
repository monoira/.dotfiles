#!/usr/bin/env bash
set -euo pipefail

echo "<--- cloning git repositories into ~/dev... --->"

mkdir -p "$HOME/dev"
cd "$HOME/dev" || exit
git clone git@github.com:monoira/general.git
git clone git@github.com:monoira/projects.git
git clone git@github.com:monoira/CVIMU.git
git clone git@github.com:monoira/interesting.git
git clone git@github.com:monoira/extracton.git
git clone git@github.com:monoira/nefoin.git
git clone git@github.com:monoira/kitty-tabs.git
cd -
