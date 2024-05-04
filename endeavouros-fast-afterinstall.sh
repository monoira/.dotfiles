#!/bin/bash

# DESCRIPTION: after installing EndeavourOS, run this script for software installation and useful configurations.

# NOTE: Function to check the exit status and print an error message

check_exit_status() {
	local status=$?
	if [ $status -ne 0 ]; then
		echo "Error: $1 failed."
		exit 1
	fi
}

# || Installing pacman and AUR packages
# installs useful pacman packages

sudo pacman -S --noconfirm zsh
check_exit_status "zsh failed"

sudo pacman -S --noconfirm zsh-syntax-highlighting
check_exit_status "zsh-syntax-highlighting failed"

sudo pacman -S --noconfirm timeshift
check_exit_status "timeshift failed"

sudo pacman -S --noconfirm nodejs
check_exit_status "nodejs failed"

sudo pacman -S --noconfirm npm
check_exit_status "npm failed"

sudo pacman -S --noconfirm git
check_exit_status "git failed"

sudo pacman -S --noconfirm lazygit
check_exit_status "lazygit failed"

sudo pacman -S --noconfirm cargo
check_exit_status "cargo failed"

sudo pacman -S --noconfirm dotnet-sdk
check_exit_status "dotnet-sdk failed"

sudo pacman -S --noconfirm aspnet-runtime
check_exit_status "aspnet-runtime failed"

sudo pacman -S --noconfirm nuget
check_exit_status "nuget failed"

sudo pacman -S --noconfirm xclip
check_exit_status "xclip failed"

sudo pacman -S --noconfirm ripgrep
check_exit_status "ripgrep failed"

sudo pacman -S --noconfirm fd
check_exit_status "fd failed"

sudo pacman -S --noconfirm ffmpegthumbs
check_exit_status "ffmpegthumbs failed"

sudo pacman -S --noconfirm neovim
check_exit_status "neovim failed"

sudo pacman -S --noconfirm otf-commit-mono-nerd
check_exit_status "otf-commit-mono-nerd failed"

sudo pacman -S --noconfirm wezterm
check_exit_status "wezterm failed"

# installs useful yay packages
yay -S --noconfirm visual-studio-code-bin
check_exit_status "visual-studio-code-bin (AUR)"

yay -S --noconfirm figma-linux
check_exit_status "figma-linux (AUR)"

# || other system configurations

# activates bluetooth on EndeavourOS
sudo systemctl start bluetooth
check_exit_status "Bluetooth activation"

sudo systemctl enable bluetooth
check_exit_status "Bluetooth enabling"

# fixing time on linux - problem of dual booting windows and linux
# https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/
timedatectl set-local-rtc 1 --adjust-system-clock
check_exit_status "Linux Time got fixed"

# activates timeshift autobackup
sudo systemctl enable --now cronie.service
check_exit_status "Timeshift autobackup activation"

# now save whatever you are doing and reboot the computer!
# test
