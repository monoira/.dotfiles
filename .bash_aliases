echi() { echo "$1"; }

search() { yay -Qeq | rg "$1" | fzf; }
