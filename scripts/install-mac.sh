#!/usr/bin/env bash

# Name the computer
echo "Setting Computer Name."
echo "This might ask for sudo privileges."
sudo scutil --set ComputerName macbook
sudo scutil --set LocalHostName macbook

# Hardening the firewall
echo "Enable the firewall with logging and stealth mode."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
echo "Prevent built-in software as well as code-signed, downloaded software from being whitelisted automatically in the firewall"
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off

# Hardening the system
echo "Setting the screen to lock as soon as the screensaver starts."
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
echo "Expose hidden files and folders."
defaults write com.apple.finder AppleShowAllFiles -bool true
chflags nohidden ~/Library
echo "Show all filename extensions."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo "Fuck iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
echo "Fuck Bonjour, Airplay and Airprint"
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES
echo "Don't allow group/other read access to your stuff"
sudo launchctl config user umask 077

# Recurively clone submodules
git submodule update --init --recursive

# Uninstall brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

if ! command -v brew &>/dev/null; then
    echo "brew could not be found, exiting"
    exit 1
fi

# Update brew
brew update && brew upgrade

# Turn off analytics
echo "Turning Off Homebrew Analytics"
brew analytics off

# Hardening brew before installing
echo "Hardening Homebrew."
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

# brew formulas
echo "Installing Homebrew Formulas."
brew install
# basics
git \
    curl \
    nmap \
    ffmpeg \
    bash-completion \
    zsh-completions \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    fzf \
    ripgrep \
    fd \
    jq \
    yt-dlp \
    lazygit \
    gh \
    tor \
    shellcheck \
    typst \
    just \
    zellij \
    hugo
# GPG
gnupg \
    pinentry-mac \
    ykman
# Neovim
neovim \
    node \ # yeah neovim needs this crap
# Rust
rustup \
    rust-analyzer \
    bacon \
    cargo-nextest \
    cargo-watch \
    sccache
# Python
uv \
    poetry \
    ruff \
    pyright
# LSPs
vscode-langservers-extracted \
    yaml-language-server \
    taplo \
    typescript-language-server \
    marksman \
    lua-language-server \
    bash-language-server \
    shfmt \
    codespell
brew services start tor

# brew casks
echo "Installing Homebrew Casks."
brew install --cask iterm2
brew install --cask tor-browser
brew install --cask keepassxc
brew install --cask kap
brew install --cask iina
brew install --cask mullvadvpn
brew install --cask transmission
brew install --cask cryptomator
brew install --cask karabiner-elements
brew install --cask dangerzone
brew install --cask yubico-yubikey-manager
#brew install --cask lulu # just hardening the firewall is enough now
#brew install --cask stats # maybe too much bloat
#brew install --cask notunes # maybe I can get away with iTunes and some mp3s
#brew install --cask aural # maybe I can get away with iTunes and some mp3s
#brew install --cask sparrow
#brew install --cask santa

# brew fonts
echo "Installing Homebrew Casks."
brew install --cask font-monaspace-nerd-font
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask font-juliamono

# Install FZF completions
"$(brew --prefix)/opt/fzf/install" --all --key-bindings --completion

# Set dotfiles
mkdir -p "$HOME"/.config
mkdir -p "$HOME"/.ssh
mkdir -p "$HOME"/.gnupg

cp -r "$PWD"/.config/git "$HOME"/.config/git
cp -r "$PWD"/.config/nvim "$HOME"/.config/nvim
cp -r "$PWD"/.config/helix "$HOME"/.config/helix
cp -r "$PWD"/.config/zellij "$HOME"/.config/zellij
cp "$PWD"/.zshrc "$HOME"/.zshrc
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

echo "pinentry-program $(which pinentry-mac)" >>~/.gnupg/gpg-agent.conf

echo "Done!"
echo "Don't forget to enable filevault and lockdown mode!"
echo "Don't forget to enable filevault and lockdown mode!"
echo "Don't forget to enable filevault and lockdown mode!"
echo ""
echo "You might want to grab more tinfoil-hat stuff at https://github.com/drduh/macOS-Security-and-Privacy-Guide"
