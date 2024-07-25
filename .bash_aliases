tlauncher() { java -jar ~/tlauncher123/TLauncher.jar; }

echi() { echo "$1"; }

search() { yay -Qeq | rg "$1" | fzf; }
