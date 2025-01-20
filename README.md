# table of content

<!--toc:start-->

- [table of content](#table-of-content)
  - [what i keep in this repository](#what-i-keep-in-this-repository)
  - [requirements and dependencies](#requirements-and-dependencies)
    - [requirements](#requirements)
    - [dependency packages](#dependency-packages)
    - [install dependency packages with this one command](#install-dependency-packages-with-this-one-command)
  - [what does all of this do?](#what-does-all-of-this-do)
  - [installation](#installation)
    - [install OhMyZsh](#install-ohmyzsh)
    - [install dotfiles](#install-dotfiles)
    - [for vim-dadbod](#for-vim-dadbod)
  - [manual tasks that can not be automated](#manual-tasks-that-can-not-be-automated)
  - [optional tips you might want to consider](#optional-tips-you-might-want-to-consider)
  - [Q&A why are you using both snap and flatpak?](#qa-why-are-you-using-both-snap-and-flatpak)
  <!--toc:end-->

## what i keep in this repository

- dotfiles managed by GNU/Stow - Neovim, Alacritty, Zsh, Cmus, gitconfig,
  and possibly more configurations
- zsh functions
- Various installation scripts
- VSCode settings & workspaces

  ( I no longer use VSCode, even in this scripts, but keep the settings anyway )

## requirements and dependencies

### requirements

- Be on Ubuntu
- Bash (Already preinstalled on Debian based distributions)
- Gnome desktop environment installed and running --
  needed for [gnome_settings.sh](./install_scripts/gnome_settings.sh)

- **OPTIONAL:** have ssh key configured w/GitHub to clone using ssh.
  You will get prompted about.

### dependency packages

- wget
- stow
- git

### install dependency packages with this one command

```bash
sudo apt install -y wget stow git
```

## what does all of this do?

- Installs useful and necessary apt and snap packages
- Installs nerd font: Hack nerd font
- Installs lazygit
- Installs vimv
- Installs lazydocker
- Configures gnome settings with gsettings to:
  hide trash on dash-to-dock, hide home, disable notifications, etc.

And possibly more.
For full info, check scripts themselves at
[start.sh](./start.sh)
and
[install_scripts](./install_scripts/) directory

## installation

### install OhMyZsh

```bash
sudo apt install -y zsh
```

```bash
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### install dotfiles

```bash
wget -qO- https://raw.githubusercontent.com/monoira/.dotfiles/main/start.sh | bash
```

### for vim-dadbod

- create file `~/.config/nvim/lua/config/dbs.lua` with such content

```lua
vim.g.dbs = {
  { name = "dev", url = "postgres://USERNAME:PASSWORD@HOST:PORT/DATABASE_NAME" },
}
```

- Replace
  USERNAME, PASSWORD, HOST, PORT and DATABASE_NAME
  with your local postgresql database data.

**When everything finishes, reboot your system! VERY IMPORTANT!**

## manual tasks that can not be automated

- add [Vim extension to Dbeaver manually](https://www.youtube.com/watch?v=soznrFTtL2s)
- add a keyboard layout
- place packages based on the following image:
  ![Image of packages on Ubuntu](./_docs/packages.png)

## optional tips you might want to consider

- pause auto update / refresh of all snap packages

```bash
sudo snap refresh --hold
```

## Q&A why are you using both snap and flatpak?

I tried to only use flatpak, but had some problems with following packages

- neovim

Neovim in apt is severely outdated, PPA version is outdated and
flatpak version is TERRIBLE, buggy and overly sandboxed.
Building .deb package with "dpkg -i" means it won't update.

- steam

Installing via flatpak or apt steam-installer didn't worked, since
it kept giving me unmet dependencies error.
Building .deb package with "dpkg -i" means it won't update.
I WILL CHECK LATER. Until then, I have to use snap version.

- figma-linux

Can't install via apt or flatpak.
Building .deb package with "dpkg -i" means it won't update.

I would love to only use flatpak and get away from snap,
But it is what it is.
I will re-check in the future if I can replace those packages
with non-snap versions and finally be snap-free.
