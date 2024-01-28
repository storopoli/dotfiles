#!/usr/bin/env bash

if [ -n "$CODESPACES" ]; then
  echo "***Loading Codespaces Dotfiles***"
  # FIXME: I'm broken
  # chmod +x ./scripts/install-codespaces.sh
  # . ./scripts/install-codespaces.sh
else
    . ./scripts/utils.sh
    os_name=$(uname)
    if [[ "$os_name" == "Darwin" ]]; then
      echo "***Loading MaCOS Dotfiles***"
      chmod +x ./scripts/install-mac.sh
      . ./scripts/install-mac.sh
    fi
fi