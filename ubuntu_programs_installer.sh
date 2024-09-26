#!/usr/bin/env bash

# NOTE: Automatic font installation

# Create a temporary directory
TEMP_DIR=$(mktemp --directory)

nerd_font_name="Hack"

nerd_fonts_repo_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$nerd_font_name.zip"

# download the font zip file
wget -O "$TEMP_DIR/font.zip" "$nerd_fonts_repo_url"

# unzip the font file
unzip "$TEMP_DIR/font.zip" -d "$TEMP_DIR"

# move the font files to the system fonts directory
sudo mkdir -p /usr/local/share/fonts/
# BUG: only works if fonts inside zip are .ttf extension. doesn't work with .otf. fix later.
sudo mv "$TEMP_DIR"/*.ttf /usr/local/share/fonts/

# update the font cache
fc-cache -f -v

# clean up
sudo rm -rf "$TEMP_DIR"

# NOTE: || apt packages:
sudo apt install -y curl
sudo apt install -y git
sudo apt install -y python3
sudo apt install -y nodejs
sudo apt install -y npm

sudo apt install -y alacritty
sudo apt install -y zsh

# NOTE: basic programs + needed for neovim
sudo apt install -y fzf
sudo apt install -y fd-find
sudo apt install -y ripgrep

# NOTE: clipboard packages
# needed for neovim - clipboard for - X11
sudo apt install -y xclip
# needed for neovim - clipboard for - wayland
sudo apt install -y wl-clipboard

# NOTE: general packages
sudo apt install -y libreoffice
sudo apt install -y vlc
sudo apt install -y timeshift
sudo apt install -y qbittorrent
sudo apt install -y strawberry
sudo apt install -y rclone
sudo apt install -y rclone-browser
sudo apt install -y virtualbox
sudo apt install -y virtualbox-ext-pack

# NOTE: || snap packages:

# normal snaps
sudo snap install postman
sudo snap install figma-linux

# snaps that need --classic flag.
sudo snap install --classic nvim
sudo snap install --classic code
sudo snap install --classic go

# NOTE: || COMPLICATED INSTALLATIONS

# lazygit installation
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit.tar.gz
rm -rf lazygit

# NOTE: those must be done manually!
# sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
