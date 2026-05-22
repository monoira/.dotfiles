#!/usr/bin/env bash
set -euo pipefail

echo "<--- installing act... --->"
sudo dnf -y copr enable goncalossilva/act
sudo dnf -y install act-cli
