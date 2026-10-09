#!/usr/bin/env bash

echo "<--- installing AWS cli... --->"

# installs system version.
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
curl -fsSL https://awscli.amazonaws.com/v2/install.sh | sudo bash -s -- --system

echo "<--- installing Pulumi... --->"

curl -fsSL https://get.pulumi.com | sh

# sets login to local, so it stops asking you for login
pulumi login --local
