# This is where I keep my

- dotfiles
- neovim configuration
- vscode settings
- vscode workspaces
- winget backup
- scripts that install them

## What Scripts to use

- on endeavourOS on any arch linux based distributions that have pacman and yay
  installed, to download packages and get setup going, run:
  [install_packages.sh](../install_packages.sh)

- on EndeavourOS, to activate bluetooth and fix other problems, run:
  [endeavouros_configurations.sh](../endeavouros_configurations.sh)

- lastly, after installing pacman & yay packages, you can run this script
  on any arch based linux distribution with bash installed to spread around
  .dotfiles ( read script itself for more info if want to ):
  [create_symlinks.sh](../create_symlinks.sh)

## Things you have to do manually since the shell can't do them or other problems

- build [docker-desktop](https://www.youtube.com/watch?v=OTmyNHTQ0AA)

- on EndeavourOS
  - add a keyboard layout
  - configure favorites based on the following image:
    ![image of favorites on EndeavourOS](./favorites_img.png)
  - NOTE: replace kTorrent with qBittorent
