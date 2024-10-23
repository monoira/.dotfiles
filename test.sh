#!/usr/bin/env bash

echo "OPERATING SYSTEM:"
awk '{print $1}' /etc/issue
