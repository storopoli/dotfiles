PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# LANG Stuff
export LANG=en
export LC_ALL=en_US.UTF-8

# VIM keybindings
set -o vi

# User specific environment variables
export EDITOR=nvim
export VISUAL=nvim
export JULIA_NUM_THREADS=auto
alias ls='ls --color=auto'
alias l='ls -CF'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'
alias lg=lazygit
alias testtor="curl -x socks5h://localhost:9050 -s https://check.torproject.org/api/ip"
alias testmullvad="curl -Ls am.i.mullvad.net/json | jq"
alias testnet="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias yt="yt-dlp --add-metadata -i --format mp4 --restrict-filenames"
alias yta="yt -x -f bestaudio/best --format mp4 --audio-format opus --restrict-filenames"
function ytp() {
    local playlist_id="$1"
    local yturl="https://www.youtube.com/playlist?list=$playlist_id"

    printf "#!/bin/sh\nyt-dlp --add-metadata -i --format mp4 --restrict-filenames --sponsorblock-remove all -o '%%(playlist_index)s-%%(title)s.%%(ext)s' --download-archive archive.txt '%s'" $yturl >command.sh
    chmod +x command.sh
    . command.sh
}

# GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)

# System binaries
PATH="/usr/local/bin:$PATH"
# Local binaries
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
	PATH="$HOME/.local/bin:$PATH"
fi
export PATH

# VIM
[[ "$(command -v vim)" ]] && export EDITOR=vim

# FZF
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Zoxide
eval "$(zoxide init bash)"

# yazi
function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ "$cwd" != "" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
