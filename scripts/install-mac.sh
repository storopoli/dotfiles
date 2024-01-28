#!/usr/bin/env bash

### Uninstall Brew ###
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

### Install Brew ###
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

if ! command -v brew &>/dev/null; then
	echo "brew could not be found, exiting"
	exit 1
fi

### Update Brew ###
brew update && brew upgrade

### Install Packages ###
brew install bash-completion zsh-completions zsh-autosuggestions zsh-syntax-highlighting
brew install fzf ripgrep fd gnupg pinentry-mac
brew install rustup nvm juliaup poetry yt-dlp lazygit gh

### Install FZF completions ###
$(brew --prefix)/opt/fzf/install --all --key-bindings --completion

### Clone and set dotfiles ###
rm -rf ~/.config/git  ~/.zshrc* ~/.zprofile* ~/.zsh_history* ~/.zsh_sessions/ ~/.zshrc ~/.zshenv
cp -r .config/git ~/.config/git
cp .zshrc ~/.zshrc
cp .ssh/config ~/.ssh/config
cp .ssh/know_hosts ~/.ssh/know_hosts
cp .gnupg/gpg.conf ~/.gnupg/gpg.conf