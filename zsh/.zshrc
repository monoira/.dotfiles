# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Setting defaults
export EDITOR=nvim
export TERMINAL=alacritty
export LANG=en_US.UTF-8

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Oh My Zsh update reminders
zstyle ':omz:update' mode reminder

# Plugins - zsh-autosuggestions and zsh-syntax-highlighting need to be last in list to work properly!
plugins=(vi-mode fzf docker zsh-autosuggestions zsh-syntax-highlighting)

# Theme
ZSH_THEME="strug"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="bira"

# Custom aliases and functions
source $HOME/.zsh_aliases

# Source Oh My Zsh config
source $ZSH/oh-my-zsh.sh
