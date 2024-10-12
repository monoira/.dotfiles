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

  After which run this script: [install_packages_on_ubuntu.sh](./install_packages_on_ubuntu.sh)
  to automate following tasks:

  - Download useful and necessary apt and snap packages
  - Download nerd font: Hack nerd font in my case ( Changeable in script )
  - Download and compile lazydocker
  - Download and compile lazygit
  - Download vimv
  - Configure gnome settings with gsettings to:
    hide trash on dash-to-dock, hide home, disable notifications, etc.

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
