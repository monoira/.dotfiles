#!/usr/bin/env bash

# apt install function
log_file=~/.0install_progress_log.txt

# function to check if package apt is installed or not
apt_package_is_installed() {
  if dpkg -s "$1" >/dev/null 2>&1; then
    return 0 # Package is installed
  else
    return 1 # Package is not installed
  fi
}

# Function to install apt packages and check installation status
install_apt_package_and_check() {
  package_name=$1
  sudo apt install -y "$package_name"
  if apt_package_is_installed "$package_name"; then
    echo "$package_name Installed." >>"$log_file"
  else
    echo "$package_name FAILED TO INSTALL!!!" >>"$log_file"
  fi
}

# NOTE: || APT PACKAGES:
sudo apt update -y && sudo apt upgrade -y
install_apt_package_and_check curl
install_apt_package_and_check build-essential
install_apt_package_and_check git
install_apt_package_and_check python3
install_apt_package_and_check python3-pip
install_apt_package_and_check golang
install_apt_package_and_check cargo
install_apt_package_and_check luarocks
install_apt_package_and_check nodejs
install_apt_package_and_check npm

install_apt_package_and_check alacritty
install_apt_package_and_check zsh
install_apt_package_and_check tmux

# basic programs + needed for neovim
install_apt_package_and_check fzf
install_apt_package_and_check fd-find
install_apt_package_and_check ripgrep

# needed for neovim - clipboard for - X11
install_apt_package_and_check xclip
# needed for neovim - clipboard for - wayland
install_apt_package_and_check wl-clipboard

# general packages
install_apt_package_and_check libreoffice
install_apt_package_and_check vlc
install_apt_package_and_check shotwell
install_apt_package_and_check screenfetch
install_apt_package_and_check htop

install_apt_package_and_check timeshift
install_apt_package_and_check qbittorrent
install_apt_package_and_check strawberry
install_apt_package_and_check rclone
install_apt_package_and_check rclone-browser
install_apt_package_and_check virtualbox
install_apt_package_and_check virtualbox-ext-pack

# NOTE: || SNAP PACKAGES:

# normal snaps
sudo snap install postman
sudo snap install figma-linux

# snaps that need --classic flag.
sudo snap install --classic nvim

# NOTE: || COMPLICATED AUTOMATIC INSTALLATIONS.

# NOTE: lazygit installation
cd /tmp
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
cd -

# NOTE: docker installation

# Add the official Docker repo
sudo install -m 0755 -d /etc/apt/keyrings
sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update -y

# Install Docker engine and standard plugins
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Give this user privileged Docker access
sudo usermod -aG docker ${USER}

# Limit log size to avoid running out of disk
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

# NOTE: lazydocker installation
cd /tmp
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazydocker.tar.gz lazydocker
sudo install lazydocker /usr/local/bin
rm lazydocker.tar.gz lazydocker
cd -

# NOTE: automatic font installation

nerd_font_name="Hack"

# Check if the font is already installed
nerd_font_check=$(fc-list : family | sort | uniq | grep "$nerd_font_name")

# If the nerd font is not installed, run the script
if [ -z "$nerd_font_check" ]; then
  # Create a temporary directory
  TEMP_FONT_DIR=$(mktemp --directory)

  nerd_fonts_repo_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$nerd_font_name.zip"

  # download the font zip file
  wget -O "$TEMP_FONT_DIR/font.zip" "$nerd_fonts_repo_url"

  # unzip the font file
  unzip "$TEMP_FONT_DIR/font.zip" -d "$TEMP_FONT_DIR"

  # create system fonts directory if it doesn't already exists
  sudo mkdir -p /usr/local/share/fonts/

  # move the font files to the system fonts directory
  # BUG: fix/DRY later. for now I will just repeat same code. for some reason *.{otf,ttf,woff,woff2} didn't worked.
  sudo mv "$TEMP_FONT_DIR"/*.otf /usr/local/share/fonts/
  sudo mv "$TEMP_FONT_DIR"/*.ttf /usr/local/share/fonts/
  sudo mv "$TEMP_FONT_DIR"/*.woff /usr/local/share/fonts/
  sudo mv "$TEMP_FONT_DIR"/*.woff2 /usr/local/share/fonts/

  # update the font cache
  fc-cache -f -v

  # clean up temporary directory
  sudo rm -rf "$TEMP_FONT_DIR"
else
  echo "$nerd_font_name is already installed."
fi

# NOTE: installing vimv - cargo required!
cargo install vimv
sudo ln -sf ~/.cargo/bin/vimv /bin/vimv
