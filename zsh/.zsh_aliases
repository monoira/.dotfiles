# NOTE: these are just for fun and testing / learning.

# find package, choose it in fzf and it will go into your clipboard.
aptfind() { apt list | rg "$1" | fzf | wl-copy; }

# prints out name of your linux distro.
# reads first word of the /etc/issue. which on ubuntu is "ubuntu"
currentLinux() { awk '{print $1}' /etc/issue; }

# large version
currentLinuxFull() { cat /etc/os-release; }
