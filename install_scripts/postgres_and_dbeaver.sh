#!/usr/bin/env bash

echo "<--- installing postgresql... --->"
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/F-43-x86_64/pgdg-fedora-repo-latest.noarch.rpm
sudo dnf install -y postgresql18-server
sudo /usr/pgsql-18/bin/postgresql-18-setup initdb
sudo systemctl enable postgresql-18
sudo systemctl start postgresql-18

echo "<--- installing dbeaver... --->"
flatpak install -y io.dbeaver.DBeaverCommunity
