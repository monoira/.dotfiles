#!/usr/bin/env bash

echo "<--- installing ghostty... --->"

sudo dnf copr enable -y scottames/ghostty
sudo dnf install -y ghostty
