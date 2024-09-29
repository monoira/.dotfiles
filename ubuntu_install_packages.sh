#!/usr/bin/env bash

# NOTE: || APT PACKAGES:
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl
sudo apt install -y git
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y golang
sudo apt install -y cargo
sudo apt install -y nodejs
sudo apt install -y npm

sudo apt install -y alacritty
sudo apt install -y zsh

# basic programs + needed for neovim
sudo apt install -y fzf
sudo apt install -y fd-find
sudo apt install -y ripgrep

# needed for neovim - clipboard for - X11
sudo apt install -y xclip
# needed for neovim - clipboard for - wayland
sudo apt install -y wl-clipboard

# general packages
sudo apt install -y libreoffice
sudo apt install -y vlc
sudo apt install -y shotwell
sudo apt install -y screenfetch

sudo apt install -y timeshift
sudo apt install -y qbittorrent
sudo apt install -y strawberry
sudo apt install -y rclone
sudo apt install -y rclone-browser
sudo apt install -y virtualbox
sudo apt install -y virtualbox-ext-pack

# NOTE: || SNAP PACKAGES:

# normal snaps
sudo snap install postman
sudo snap install figma-linux

# snaps that need --classic flag.
sudo snap install --classic nvim
sudo snap install --classic code

# NOTE: || COMPLICATED INSTALLATIONS.

# lazygit installation
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit.tar.gz
rm -rf lazygit

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
