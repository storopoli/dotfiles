#!/bin/sh

# install packages
sudo pacman -S \
 # tools
 which parallel fzf detox ripgrep \
 # chezmoi
 chezmoi \
 # zsh
 zsh zsh zsh-completions zsh-autosuggestions zsh-fast-syntax-highlighting \
 # dev
 julia python r rust rust-src go btop make cmake jq \
 # editor 
 neovim kitty tree-sitter \
 # language servers
 clang lua-language-server texlab gopls pyright rust-analyzer vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver typescript typescript-language-server bash-language-server \
 # linetrs
 stylua python-black rustfmt prettier lldb shellcheck \
 # utils
 bat lazygit ranger ffmpeg yt-dlp aria2 tectonic neofetch chafa \
 # fonts
 noto-fonts noto-fonts-emoji

# chezmoi stuff
chezmoi init --apply git@github.com:storopoli/dotfiles.git

# change shell to zsh
chsh -s /bin/zsh

# export apps
distrobox-export --app kitty
distrobox-export --bin $(which kitty) --export-path $HOME/.local/bin

# Nerd Fonts
mkdir -p "$HOME/.local/share/fonts"
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip -d "$HOME/.local/share/fonts" Hack*.zip
rm Hack*.zip
fc-cache -f -v
