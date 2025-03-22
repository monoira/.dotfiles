#!/usr/bin/env bash

echo "<--- installing nvm... --->"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install --lts
nvm use --lts
