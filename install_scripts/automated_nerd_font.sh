#!/usr/bin/env bash

# NOTE: function that automatically installs nerd font

# first and only argument: name of the nerd font that is inside ryanoasis/nerd-fonts repository on github.
# WARN: make sure you check and write font name in right case. In case of "Hack" nerd font:
# GOOD: Hack
# BAD: hack
install_nerd_font() {
  local nerd_font_name=$1
  echo "<--- Installing $nerd_font_name nerd font... --->"

  # Check if the font is already installed
  local nerd_font_check
  nerd_font_check=$(fc-list : family | sort | uniq | grep "$nerd_font_name")

  # If the nerd font is not installed, runs the following script
  if [ -z "$nerd_font_check" ]; then
    # Create a temporary directory
    TEMP_FONT_DIR=$(mktemp --directory)

    local nerd_fonts_repo_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$nerd_font_name.zip"

    # download the font zip file
    wget -O "$TEMP_FONT_DIR/font.zip" "$nerd_fonts_repo_url"

    # unzip the font file
    unzip "$TEMP_FONT_DIR/font.zip" -d "$TEMP_FONT_DIR"

    # create system fonts directory if it doesn't already exists
    sudo mkdir -p /usr/local/share/fonts/

    # move the font files to the system fonts directory
    sudo mv "$TEMP_FONT_DIR"/*.{otf,ttf,woff,woff2} /usr/local/share/fonts/

    # update the font cache
    fc-cache -f -v

    # clean up temporary directory
    sudo rm -rf "$TEMP_FONT_DIR"
  else
    echo "<--- $nerd_font_name is already installed. --->"
  fi
}

install_nerd_font "Hack"
