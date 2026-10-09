#!/usr/bin/env bash

echo "<--- installing AWS cli... --->"

curl -fsSL https://awscli.amazonaws.com/v2/install.sh | sudo bash -s -- --system

echo "<--- installing pulumi... --->"

curl -fsSL https://get.pulumi.com | sh

