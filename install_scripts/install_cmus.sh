#!/usr/bin/env bash

echo "<--- installing cmus... --->"

sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
sudo dnf install -y cmus
