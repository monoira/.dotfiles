# TABLE OF CONTENTS

- [TABLE OF CONTENTS](#table-of-contents)
  - [content of this repository](#content-of-this-repository)
  - [requirements and dependencies](#requirements-and-dependencies)
    - [requirements](#requirements)
    - [dependency packages](#dependency-packages)
    - [install dependency packages with this one command](#install-dependency-packages-with-this-one-command)
  - [what does start.sh script do](#what-does-startsh-script-do)
  - [installation](#installation)
    - [install OhMyZsh](#install-ohmyzsh)
    - [install dotfiles](#install-dotfiles)
    - [installing vscode and setting up global settings.json](#installing-vscode-and-setting-up-global-settingsjson)
  - [manual tasks that can not be automated](#manual-tasks-that-can-not-be-automated)
  - [optional tips you might want to consider](#optional-tips-you-might-want-to-consider)
  - [update submodules](#update-submodules)
  - [DONATE](#donate)

## content of this repository

- VSCode profile / settings and workspaces as primary code editor.
  Setup with AI Agent and vim extension with LazyVim keybindings in mind for maximum productivity.  
  Powered by [VSCLazy](https://github.com/monoira/VSCLazy).
- dotfiles and configs managed by GNU/Stow - Kitty, Zsh, Cmus, gitconfig,
  and more.
- zsh functions.
- Various installation scripts.

## requirements and dependencies

### requirements

- Be on Fedora
- Bash
- Gnome desktop environment installed and
  running -- required for [slickgnome](https://github.com/monoira/slickgnome)
- Have ssh key configured w/GitHub to clone using ssh.

### dependency packages

- wget
- stow
- git

### install dependency packages with this one command

```bash
sudo dnf install -y stow git wget
```

## what does start.sh script do

- Installs useful and necessary packages
- Installs nerd font: Hack Nerd Font
- Installs lazygit
- Installs vimv
- Configures gnome settings with gsettings via [slickgnome](https://github.com/monoira/slickgnome)

And possibly more.
For full info, check scripts themselves at
[start.sh](./start.sh)
and
[install_scripts](./install_scripts/) directory

## installation

### install OhMyZsh

```bash
sudo dnf install -y zsh
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

### installing vscode and setting up global settings.json

1. open vscode - required so `$HOME/.config/Code/User` gets created
2. import [vscode profile](./vscode/profiles)
3. clone and open workspaces
4. run following script to
   - symlinking vscode global settings.json, which includes vscode-vim extension keybindings.

```bash
ln -sf "$HOME/.dotfiles/VSCLazy/settings.json" "$HOME/.config/Code/User/settings.json"
```

**When everything finishes, reboot your system! VERY IMPORTANT!**

## manual tasks that can not be automated

- change refresh rate in `settings > refresh rate` to 155 Hz
- add a keyboard layout
- in `about:config` of firefox, change these:
  - `full-screen-api.warning.timeout` to `0`
  - `extensions.pocket.enabled` to `false`
- `Software & Updates > Updates > Automatically check for updates` to `never`
- add [Vim extension to Dbeaver manually](https://www.youtube.com/watch?v=soznrFTtL2s)
- place packages based on the following image:
  ![Image of packages on Fedora](./docs/packages.png)

## optional tips you might want to consider

- pause auto update / refresh of all snap packages

```bash
sudo snap refresh --hold
```

- use latest LTS version of nodejs and npm via nvm

```bash
nvm install --lts && nvm use --lts
```

## update submodules

```bash
git submodule update --remote --merge
git add . && git commit -m "chore: updated submodules" && git push
```

## DONATE

I've been creating FOSS / GNU/Linux / nvim / web
related software for some time now.  
If you used, forked or took code from one of my projects and you
would like to support me 👍,  
you can donate here:

| type                | address                                    |
| ------------------- | ------------------------------------------ |
| Bitcoin (SegWit)    | bc1ql8sp9shx4svzlwv0ckzv8s7pphw5upvmt8m2m7 |
| Ethereum (Ethereum) | 0xf2FCB0Af39DF7A608b76297e45181aF23fEB939F |
