#!/usr/bin/env bash

echo "<--- changing gsettings to customize gnome desktop environment to my taste --->"

# night-light settings
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 20.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4000

# dash-to-dock settings
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.desktop.interface clock-show-date false

# show apps from current workspace only
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.window-switcher current-workspace-only true

# hide the trash from dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

# desktop icons size
gsettings set org.gnome.shell.extensions.ding icon-size 'small'
# hides home directory on desktop
gsettings set org.gnome.shell.extensions.ding show-home false

# disable update notifications
gsettings set com.ubuntu.update-notifier no-show-notifications true
# disables notification banners
gsettings set org.gnome.desktop.notifications show-banners true
