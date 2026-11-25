#!/usr/bin/env bash

echo "<--- installing lazygit... --->"
sudo dnf copr enable -y dejan/lazygit
sudo dnf install -y lazygit

echo "<--- installing act... --->"
sudo dnf copr enable -y goncalossilva/act
sudo dnf install -y act-cli

echo "<--- installing ghostty... --->"
sudo dnf copr enable -y scottames/ghostty
sudo dnf install -y ghostty
