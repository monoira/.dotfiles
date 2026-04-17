#!/usr/bin/env bash

echo "<--- installing act... --->"

cd /tmp || exit
wget -qO act.tar.gz https://github.com/nektos/act/releases/latest/download/act_Linux_x86_64.tar.gz
sudo tar xf act.tar.gz -C /usr/local/bin act
rm act.tar.gz
cd - || exit
