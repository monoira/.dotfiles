#!/usr/bin/env bash
# NOTE: To ensure compatibility with 32-bit and 64-bit games in Steam’s extensive library, enable 32-bit support.
# Lower-end systems, which often run 32-bit games, particularly benefit from this support.
# Meanwhile, high-powered systems experience no negative impact from installing additional packages.
# To enable 32-bit support on your Ubuntu system, run the following command:
sudo dpkg --add-architecture i386

# NOTE: FOR SOME REASON, IT DIDN'T WORKED. TRY AGAIN ON NEW PC.
# if it still doesn't work, install it with wget or curl.

# echo "<--- installing heroicgameslauncher... --->"
# flatpak install flathub com.heroicgameslauncher.hgl

echo "<--- installing Steam... --->"
sudo snap install steam