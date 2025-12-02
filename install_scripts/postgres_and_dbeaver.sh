#!/usr/bin/env bash

echo "<--- installing postgresql... --->"
sudo dnf install postgresql-server postgresql-contrib
sudo systemctl enable postgresql
sudo postgresql-setup --initdb --unit postgresql
sudo systemctl start postgresql

echo "<--- installing dbeaver... --->"
flatpak install -y io.dbeaver.DBeaverCommunity
