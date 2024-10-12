<!--toc:start-->

- [What I keep in this repository](#what-i-keep-in-this-repository)
  - [What Scripts to use and in what order](#what-scripts-to-use-and-in-what-order)
  - [Tasks you have to do manually because of certain problems](#tasks-you-have-to-do-manually-because-of-certain-problems)
  <!--toc:end-->

# What I keep in this repository

- dotfiles - Neovim, Alacritty, Zsh and gitconfig configurations.
- Vscode settings & workspaces
- bash aliases
- Scripts that install them on ubuntu

## What Scripts to use and in what order

- On Ubuntu, you MUST clone this repository with submodules at ~/ using one of the following commands

HTTPS cloning

```bash
git clone --recurse-submodules https://github.com/monoira/.dotfiles.git ~/.dotfiles
```

SSH cloning

```bash
git clone --recurse-submodules git@github.com:monoira/.dotfiles.git ~/.dotfiles
```

After which to automatically download packages, nerd font, docker, etc
and get setup going, run:
[install_packages_on_ubuntu.sh](./install_packages_on_ubuntu.sh)

When script finishes, reboot your system.

- Run this to create and spread around dotfile symlinks
  [create_symlinks.sh](./create_symlinks.sh)

## Tasks you have to do manually because of certain problems

oh-my-zsh installation

```bash
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

```bash
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

```bash
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- Add a keyboard layout
- Place packages based on the following image:
  ![Image of packages on Ubuntu](./_docs/packages.png)
