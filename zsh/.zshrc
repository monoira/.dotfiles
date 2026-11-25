# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Setting defaults
# my actual editor is vscode, but I need it to be nvim here for vimv
export EDITOR=nvim
export BROWSER=firefox
export TERMINAL=ghostty

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Oh My Zsh update reminders
zstyle ':omz:update' mode disabled

# Disable Oh My Zsh automatic terminal title, using ghostty title instead
DISABLE_AUTO_TITLE="true"

# Plugins - zsh-autosuggestions and zsh-syntax-highlighting need to be last in list to work properly!
plugins=(vi-mode fzf docker colored-man-pages extract nvm zsh-autosuggestions zsh-syntax-highlighting)

# Theme
ZSH_THEME="strug"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="bira"

# Source Oh My Zsh config
source $ZSH/oh-my-zsh.sh

# Custom aliases
source $HOME/.zsh_aliases

# Custom functions loaded automatically
fpath=(~/.zfunc "${fpath[@]}")
autoload -Uz $fpath[1]/*(.:t)

# load all system binaries
export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH=/home/ira/.opencode/bin:$PATH

# pulumi
export PATH=$PATH:/home/ira/.pulumi/bin

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# dotnet-install
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools
