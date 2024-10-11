#!/usr/bin/env bash

# NOTE: || APT PACKAGES:
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y curl
sudo apt install -y build-essential
sudo apt install -y git
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y golang
sudo apt install -y cargo
sudo apt install -y luarocks
sudo apt install -y nodejs
sudo apt install -y npm

sudo apt install -y alacritty
sudo apt install -y zsh
sudo apt install -y tmux

# basic programs + needed for neovim
sudo apt install -y fzf
sudo apt install -y fd-find
sudo apt install -y ripgrep

# needed for neovim - clipboard for - X11
sudo apt install -y xclip
# needed for neovim - clipboard for - wayland
sudo apt install -y wl-clipboard

# general packages
sudo apt install -y screenfetch
sudo apt install -y htop
sudo apt install -y timeshift

sudo apt install -y libreoffice
sudo apt install -y vlc
sudo apt install -y shotwell

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

# NOTE: changing gsettings to customize gnome desktop environment to my taste

# hide the trash from dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

# night-light settings
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 20.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4000

# show apps from current workspace only
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.window-switcher current-workspace-only true

# desktop icons size
gsettings set org.gnome.shell.extensions.ding icon-size 'small'

# dash-to-dock settings
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.desktop.interface clock-show-date false

# disable update notifications
gsettings set com.ubuntu.update-notifier no-show-notifications true
