#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
### Enable Extra Repositories ###
sudo add-apt-repository restricted
sudo add-apt-repository universe
sudo apt-get update

# Install Packages
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq curl git zsh ripgrep fzf fd lazygit

### Configure Zsh ###
sudo chsh -s $(which zsh) $USER
### Install Zsh Plugins ###
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting

### Install dotfiles ###
ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/.zshrc $HOME/.zshrc
ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/.config/git/config $HOME/.gitconfig
ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/.config/git/ignore $HOME/.gitignore