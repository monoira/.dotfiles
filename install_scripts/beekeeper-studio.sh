#!/usr/bin/env bash
# NOTE:
# https://docs.beekeeperstudio.io/installation/linux/#deb

# Install our GPG key
curl -fsSL https://deb.beekeeperstudio.io/beekeeper.key | sudo gpg --dearmor --output /usr/share/keyrings/beekeeper.gpg &&
  sudo chmod go+r /usr/share/keyrings/beekeeper.gpg &&
  echo "deb [signed-by=/usr/share/keyrings/beekeeper.gpg] https://deb.beekeeperstudio.io stable main" |
  sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list >/dev/null

# Update apt and install
sudo apt update -y && sudo apt install beekeeper-studio -y
