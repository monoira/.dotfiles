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
zstyle ':omz:update' mode disabled

# Plugins - zsh-autosuggestions and zsh-syntax-highlighting need to be last in list to work properly!
plugins=(vi-mode fzf docker zsh-autosuggestions zsh-syntax-highlighting)

# Theme
ZSH_THEME="strug"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="bira"

# Source Oh My Zsh config
source $ZSH/oh-my-zsh.sh

# Custom aliases
source $HOME/.zsh_aliases

# Custom functions loaded automatically
fpath=( ~/.zfunc "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
