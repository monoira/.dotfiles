# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Oh My Zsh update reminders
zstyle ':omz:update' mode reminder

# Plugins - zsh-autosuggestions and zsh-syntax-highlighting need to be last in list to work properly!
plugins=(docker vi-mode fzf zsh-autosuggestions zsh-syntax-highlighting)

# Theme
ZSH_THEME="strug"

# Setting defaults
export EDITOR=nvim
export TERMINAL=alacritty

# Custom aliases and functions
source $HOME/.bash_aliases

# Source Oh My Zsh config
source $ZSH/oh-my-zsh.sh
