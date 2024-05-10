# This is where I keep my

- dotfiles
- neovim configuration
- vscode settings
- vscode workspaces
- winget backup
- scripts that install them

## What Scripts to use

- on endeavourOS or any arch linux based distributions that have pacman and yay
  installed, run [install_packages.sh](./install_packages.sh)
  to download packages and get setup going.

- on endeavourOS, run [endeavouros_configurations.sh](./endeavouros_configurations.sh)
  to activate bluetooth and fix other problems

- lastly, after installing pacman & yay packages, you can run this script
  on any arch based platform with bash: [create_symlinks.sh](./create_symlinks.sh)
  to spread around .dotfiles ( read script itself for more info )

## Things you have to do manually since the shell can't do them or other problems

- build [docker-desktop](https://www.youtube.com/watch?v=OTmyNHTQ0AA)

- on endeavourOS
  - add a keyboard layout
  - configure LibreOffice dark mode
