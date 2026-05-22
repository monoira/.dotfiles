#!/usr/bin/env bash
set -euo pipefail

echo "<--- installing Hack nerd font via monoira/nefoin... --->"

nerd_font_name="Hack" bash <(curl -fsSL https://raw.githubusercontent.com/monoira/nefoin/main/install.sh)
