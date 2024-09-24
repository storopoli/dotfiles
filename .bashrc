# LANG Stuff
export LANG=en
export LC_ALL=en_US.UTF-8

# User specific environment variables
export EDITOR=nvim
export VISUAL=nvim
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
alias ytv="yt-dlp --add-metadata -i --restrict-filenames"
alias yta="yt -x -f bestaudio/best --format mp4 --audio-format opus --restrict-filenames"
function ytp() {
    local playlist_id="$1"
    local yturl="https://www.youtube.com/playlist?list=$playlist_id"

    printf "#!/bin/sh\nyt-dlp --add-metadata -i --format mp4 --restrict-filenames --sponsorblock-remove all -o '%%(playlist_index)s-%%(title)s.%%(ext)s' --download-archive archive.txt '%s'" $yturl >command.sh
    chmod +x command.sh
    . command.sh
}

rustup-cleanup() {
    if ! command -v rustup &>/dev/null; then
        echo "rustup not found"
        return 1
    fi
    # rustup returns an echo saying "no installed toolchains"
    if $(rustup toolchain list | grep -q 'no installed toolchains'); then
        echo "no installed toolchains"
        rustup show
        return 0
    fi
    rustup toolchain list | grep -E 'stable|nightly' | awk '{print $1}' | xargs -n1 rustup toolchain uninstall
    rustup show
    return 0
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

# Vim/Nvim
[[ "$(command -v vim)" ]] && export EDITOR=vim
[[ "$(command -v nvim)" ]] && export EDITOR=nvim

# FZF
if [[ "$(command -v fzf)" ]]; then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
fi

# atuin
[[ "$(command -v atuin)" ]] && eval "$(atuin init bash)"

# direnv
[[ "$(command -v direnv)" ]] && eval "$(direnv hook bash)"

# rustup
[[ "$(command -v cargo)" ]] && source "$HOME/.cargo/env"

# sccache
[[ "$(command -v sccache)" ]] && export RUSTC_WRAPPER=sccache
