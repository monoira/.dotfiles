# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Oh My Zsh update reminders
zstyle ':omz:update' mode reminder

# Plugins
plugins=(docker vi-mode fzf)

# Theme
ZSH_THEME="strug"

# Set nvim as default editor
export EDITOR=nvim

# Custom aliases and function in .aliases file
source $HOME/.bash_aliases

# Source Oh My Zsh config
source $ZSH/oh-my-zsh.sh

# Auto suggestions and syntax highlighting - MUST BE AT THE VERY BOTTOM
autoload -Uz compinit && compinit
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
