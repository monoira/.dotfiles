#!/usr/bin/env bash

echo "<--- installing postgresql... --->"
sudo apt install -y postgresql

echo "<--- installing dbeaver... --->"
sudo wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update -y && sudo apt install -y dbeaver-ce
