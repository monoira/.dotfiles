#!/usr/bin/env bash

echo "<--- installing lazygit... --->"

sudo dnf copr enable -y dejan/lazygit
sudo dnf install -y lazygit
