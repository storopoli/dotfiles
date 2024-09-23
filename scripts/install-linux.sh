#!/usr/bin/env bash

mkdir -p "$HOME"/.config
mkdir -p "$HOME"/.ssh
mkdir -p "$HOME"/.gnupg

cp -r "$PWD"/.config/git "$HOME"/.config/git
cp -r "$PWD"/.config/nvim "$HOME"/.config/nvim
cp -r "$PWD"/.config/helix "$HOME"/.config/helix
cp -r "$PWD"/.config/zellij "$HOME"/.config/zellij
cp "$PWD"/.bashrc "$HOME"/.bashrc
cp "$PWD"/.ssh/config "$HOME"/.ssh/config
cp "$PWD"/.ssh/known_hosts "$HOME"/.ssh/known_hosts
cp "$PWD"/.gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
cp "$PWD"/.gnupg/gpg-agent.conf "$HOME"/.gnupg/gpg-agent.conf

# Set appropriate permissions for SSH and GnuPG files
chmod 700 "$HOME"/.ssh
chmod 700 "$HOME"/.gnupg
chmod 600 "$HOME"/.ssh/config
chmod 644 "$HOME"/.ssh/known_hosts
chmod 600 "$HOME"/.gnupg/*

sudo cp "$PWD"/distrobox.ini /etc/distrobox.ini

echo "All necessary files have been copied."
