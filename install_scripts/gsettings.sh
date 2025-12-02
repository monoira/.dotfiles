#!/usr/bin/env bash

echo "<--- changing gsettings to customize gnome desktop environment to my taste... --->"

# night-light settings
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 20.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4000

gsettings set org.gnome.desktop.interface clock-show-date false

# shows apps from current workspace only
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.window-switcher current-workspace-only true

# turns off mouse acceleration
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

# turn off ANNOYING droplet error notification sound
gsettings set org.gnome.desktop.sound event-sounds false

# || note: EXTRA - SPECIFIC TO MY PC.
# disable "screen locking after period of inactivity"
gsettings set org.gnome.desktop.session idle-delay 0

# turning on "Accessibility > Large Text" automatically
gsettings set org.gnome.desktop.interface text-scaling-factor 1.25

# set 'kitty' as default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec 'kitty'
