#!/usr/bin/env bash

echo "OPERATING SYSTEM:"
awk '{print $1}' /etc/issue

echo "STUFF:"
sudo rm -rf ~/Desktop/file.txt
