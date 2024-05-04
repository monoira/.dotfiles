export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# You may need to manually set your language environment
# export LANG=en_US.UTF-8



source $ZSH/oh-my-zsh.sh
bindkey -v
zstyle :compinstall filename '/home/irakli/.zshrc'

autoload -Uz compinit
compinit

# || MINE

ZSH_THEME="robbyrussell"

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

alias n="nvim"
