aptfind() { apt list | rg "$1" | fzf; }
