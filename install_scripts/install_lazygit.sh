#!/usr/bin/env bash
set -euo pipefail

echo "<--- installing lazygit... --->"

sudo dnf copr enable -y dejan/lazygit
sudo dnf install -y lazygit
