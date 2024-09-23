#!/usr/bin/env bash

os_name=$(uname)
if [[ "$os_name" == "Linux" ]]; then
    echo "***Loading Linux Dotfiles***"
    . ./scripts/install-linux.sh
else
    if [[ "$os_name" == "Darwin" ]]; then
        echo "***Loading MaCOS Dotfiles***"
        chmod +x ./scripts/install-mac.sh
        . ./scripts/install-mac.sh
    fi
fi
