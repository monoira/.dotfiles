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
sudo apt install curl
sudo apt install git
sudo apt install python3
sudo apt install nodejs
sudo apt install npm

sudo apt install alacritty
sudo apt install zsh

sudo apt install fzf
sudo apt install fd-find
sudo apt install ripgrep

# needed for neovim - clipboard for - X11
sudo apt install xclip
# needed for neovim - clipboard for - wayland
sudo apt install wl-clipboard

sudo apt install vlc
sudo apt install libreoffice

# NOTE: || snap packages:

# needs --classic flag.
sudo snap install nvim --classic
sudo snap install go --classic

# NOTE: ||| COMPLICATED INSTALLATIONS

# lazygit installation
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit.tar.gz
rm -rf lazygit

# those must be done manually!
# sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
