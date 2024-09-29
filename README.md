# This is where I keep my

- dotfiles + Neovim, Alacritty, Zsh and gitconfig configurations.
- Vscode settings & workspaces
- bash aliases
- Scripts that install them on ubuntu

## What Scripts to use

- On Ubuntu, to automatically download packages, fonts, etc
  and get setup going, run:
  [ubuntu_install_packages.sh](./ubuntu_install_packages.sh)

- Run this to spread around .dotfiles
  [create_symlinks.sh](./create_symlinks.sh)

## Things you have to do on Ubuntu manually since the shell can't do them or other problems

### oh-my-zsh installation

```bash
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Change default terminal on ubuntu. Needs to be done manually even if $TERMINAL & $EDITOR is changed

```bash
  sudo update-alternatives --config x-terminal-emulator
  sudo update-alternatives --config editor
```

- Build [docker-desktop](https://www.youtube.com/watch?v=OTmyNHTQ0AA)

- Add a keyboard layout
- Place packages based on the following image:
  ![Image of packages on Ubuntu](./_docs/packages.png)
