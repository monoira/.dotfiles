# What I keep in this repository

<!--toc:start-->

- [What I keep in this repository](#what-i-keep-in-this-repository)

  - [REQUIREMENTS AND REQUIRED PACKAGES](#requirements-and-required-packages)
    - [requirements](#requirements)
    - [required packages](#required-packages)
    - [Install required packages with this command](#install-required-packages-with-this-command)
  - [What does all of this do?](#what-does-all-of-this-do)
  - [Installation](#installation)
  - [Why are you using both snap and flatpak?](#why-are-you-using-both-snap-and-flatpak)
    - [I tried to only use flatpak, but had some problems with following packages](#i-tried-to-only-use-flatpak-but-had-some-problems-with-following-packages)
  - [Manual tasks that can not be automated](#manual-tasks-that-can-not-be-automated)
  - [Optional tips you might want to consider](#optional-tips-you-might-want-to-consider)
  <!--toc:end-->

- dotfiles managed by GNU/Stow - Neovim, Alacritty, Zsh, Cmus, gitconfig,
  and possibly more configurations
- zsh functions
- Various installation scripts
- VSCode settings & workspaces

  ( I no longer use VSCode, even in this scripts, but keep the settings anyway )

## REQUIREMENTS AND REQUIRED PACKAGES

### requirements

- Be on Ubuntu
- Have ssh key generated and be logged in to Github with it.
  Needed for SSH git cloning.
- Gnome desktop environment installed and running
- Bash (Already preinstalled on Debian based distributions)

### required packages

- wget
- stow
- git

### Install required packages with this command

```bash
sudo apt install -y wget stow git
```

## What does all of this do?

- Downloads useful and necessary apt and snap packages
- Downloads nerd font: Hack nerd font
- Downloads and compiles lazydocker
- Downloads and compiles lazygit
- Downloads vimv
- Configures gnome settings with gsettings to:
  hide trash on dash-to-dock, hide home, disable notifications, etc.

And possibly more.
For full info, check scripts themselves at
[start.sh](./start.sh)
and
install_scripts directory

## Installation

METHOD SPECIFIC REQUIREMENTS:

- Must have ssh key and be signed in to Github with it
  since this script uses git clone with ssh

```bash
wget -qO- https://raw.githubusercontent.com/monoira/.dotfiles/main/start.sh | bash
```

When scripts finish, reboot your system.

## Why are you using both snap and flatpak?

### I tried to only use flatpak, but had some problems with following packages

- neovim
  neovim in apt is severely outdated, PPA version is outdated and
  flatpak version is TERRIBLE, buggy and overly sandboxed.
  Building .deb package with "dpkg -i" means it won't update.

- steam
  installing via flatpak or apt steam-installer didn't worked, since
  it kept giving me unmet dependencies error.
  Building .deb package with "dpkg -i" means it won't update.
  I WILL CHECK LATER. Until then, I have to use snap version.

- figma-linux
  can't install via apt or flatpak.
  Building .deb package with "dpkg -i" means it won't update.

I would love to only use flatpak and get away from snap,
But it is what it is.
I will re-check in the future if I can replace those packages
with non-snap versions and finally be snap-free.

## Manual tasks that can not be automated

- install OhMyZsh

  ```bash
      sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
  ```

  ```bash
      git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ```

  ```bash
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

- add [Vim extension to Dbeaver manually](https://www.youtube.com/watch?v=soznrFTtL2s)
- add a keyboard layout
- place packages based on the following image:
  ![Image of packages on Ubuntu](./_docs/packages.png)

## Optional tips you might want to consider

- pause auto update / refresh of all snap packages

```bash
sudo snap refresh --hold
```
