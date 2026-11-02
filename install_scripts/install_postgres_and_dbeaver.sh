#!/usr/bin/env bash

echo "<--- installing postgresql... --->"

# NOTE: update this script, especially POSTGRES_VERSION, when new postgres release comes out.
# this just works for now with automated detection of fedora version and using POSTGRES_VERSION 18
# https://www.postgresql.org/download/linux/redhat/

FEDORA_VERSION="${FEDORA_VERSION:-$(. /etc/os-release 2>/dev/null && echo "${VERSION_ID:-45}")}"
POSTGRES_VERSION="18"

sudo dnf install -y "https://download.postgresql.org/pub/repos/yum/reporpms/F-${FEDORA_VERSION}-x86_64/pgdg-fedora-repo-latest.noarch.rpm"
sudo dnf install -y "postgresql${POSTGRES_VERSION}-server"
sudo /usr/pgsql-${POSTGRES_VERSION}/bin/postgresql-${POSTGRES_VERSION}-setup initdb
sudo systemctl enable "postgresql-${POSTGRES_VERSION}"
sudo systemctl start "postgresql-${POSTGRES_VERSION}"

echo "<--- installing dbeaver... --->"

flatpak install -y io.dbeaver.DBeaverCommunity
