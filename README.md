# What I keep in this repository

<!--toc:start-->

- [What I keep in this repository](#what-i-keep-in-this-repository)

  - [REQUIREMENTS AND REQUIRED PACKAGES](#requirements-and-required-packages)
    - [Auto Installation (Recommended)](#auto-installation-recommended)
      - [What this script does](#what-this-script-does)
    - [Manual installation](#manual-installation)
  - [Tasks you have to do manually because of certain problems](#tasks-you-have-to-do-manually-because-of-certain-problems)
  - [How to uninstall](#how-to-uninstall)
  <!--toc:end-->

- dotfiles - Neovim, Alacritty, Zsh and gitconfig configurations.
- VSCode settings & workspaces
  ( I no longer use VSCode, even in this scripts, but keep the settings anyway )
- Bash aliases
- Scripts that install them

## REQUIREMENTS AND REQUIRED PACKAGES

- Ubuntu or any Debian based distribution with snap and
  gnome desktop environment installed
- Bash (Already preinstalled on Debian based distributions)
- Git
- Wget

### Auto Installation (Recommended)

METHOD SPECIFIC REQUIREMENTS:

- Must have ssh key and be signed in to Github with it
  since this script uses git clone with ssh

```bash
wget -qO- https://raw.githubusercontent.com/monoira/.dotfiles/main/start.sh | bash
```

#### What this script does

- Download useful and necessary apt and snap packages
- Download nerd font: Hack nerd font
- Download and compile lazydocker
- Download and compile lazygit
- Download vimv
- Configure gnome settings with gsettings to:
  hide trash on dash-to-dock, hide home, disable notifications, etc.

When scripts finish, signaled by

<--- SYMLINKS HAVE BEEN SET. SCRIPTS ARE FINISHED. --->

Being echoed in terminal, reboot your system.

### Manual installation

METHOD SPECIFIC REQUIREMENTS:

- You MUST clone this repository with submodules at ~/ using one of the following commands

SSH cloning

```bash
git clone --recurse-submodules git@github.com:monoira/.dotfiles.git ~/.dotfiles
```

HTTPS cloning

```bash
git clone --recurse-submodules https://github.com/monoira/.dotfiles.git ~/.dotfiles
```

After which run this script: [install.sh](./install.sh) like this:

```bash
bash ~/.dotfiles/install.sh
```

To automate following tasks:

- Download useful and necessary apt and snap packages
- Download nerd font: Hack nerd font
- Download and compile lazydocker
- Download and compile lazygit
- Download vimv
- Configure gnome settings with gsettings to:
  hide trash on dash-to-dock, hide home, disable notifications, etc.

Then Run this script [create_symlinks.sh](./create_symlinks.sh) to create
and spread around dotfile symlinks like this:

```bash
bash ~/.dotfiles/create_symlinks.sh
```

When scripts finish, signaled by

<--- SYMLINKS HAVE BEEN SET. SCRIPTS ARE FINISHED. --->

Being echoed in terminal, reboot your system.

## Tasks you have to do manually because of certain problems

- Install Oh-My-Zsh

  ```bash
      sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
  ```

  ```bash
      git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ```

  ```bash
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

- Add [Vim extension to Dbeaver manually](https://www.youtube.com/watch?v=soznrFTtL2s)
- Add a keyboard layout
- Place packages based on the following image:
  ![Image of packages on Ubuntu](./_docs/packages.png)

## How to uninstall

```bash
wget -qO- https://raw.githubusercontent.com/monoira/.dotfiles/main/uninstall.sh | bash
```

note: this will only remove config files & directories, Not Programs installed.
Warning: this will remove AKA rm -rf

~/.bashrc
~/.zshrc
~/.zsh_aliases
~/.gitconfig
~/.config/nvim
~/.config/alacritty
~/.config/tmux

And possibly more.
For full info on what [uninstall.sh](./uninstall.sh) will remove,
check [uninstall.sh](./uninstall.sh) script itself.
