# activates bluetooth on EndeavourOS
sudo systemctl start bluetooth

sudo systemctl enable bluetooth

# fixing time on linux - problem of dual booting windows and linux
# https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/
timedatectl set-local-rtc 1 --adjust-system-clock

# activates timeshift daily autobackup
sudo systemctl enable --now cronie.service
