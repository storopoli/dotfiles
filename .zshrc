# Enable colors and change prompt:
autoload -U colors && colors # Load colors
autoload -U promptinit
promptinit
stty stop undef # Disable ctrl-s to freeze terminal.
setopt extendedglob

# LANG Stuff
export LANG=en
export LC_ALL=en_US.UTF-8

# History
export HISTSIZE=1000000
export HISTFILE=~/.bash_history
export SAVEHIST=1000000
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry
setopt HIST_VERIFY            # Don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY     # Save history on every command not shell exit

# Basic auto/tab complete:
autoload -Uz compinit select-word-style
select-word-style bash
zstyle ':completion:*' menu select, use-cache 1
zstyle ':autocomplete:*' fzf-completion yes
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Ctrl + left/right
# check out: https://unix.stackexchange.com/questions/58870/ctrl-left-right-arrow-keys-issue
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# Ctrl + backspace/delete
# check out: https://unix.stackexchange.com/questions/12787/zsh-kill-ctrl-backspace-ctrl-delete
bindkey '^H' backward-kill-word
bindkey '^[[3;' kill-word

# User specific environment variables
export EDITOR=vim
export VISUAL=vim
alias ls='ls --color=auto'
alias l='ls -CF'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'
alias testtor="curl -x socks5h://localhost:9050 -s https://check.torproject.org/api/ip"
alias testmullvad="curl -Ls am.i.mullvad.net/json | jq"

# brew
if [ -f /opt/homebrew/bin/brew ]; then
    brew_prefix="$(/opt/homebrew/bin/brew --prefix)"
    eval "$("$brew_prefix"/bin/brew shellenv)"
fi
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

# GPG
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export SSH_AUTH_SOCK
GPG_TTY=$(tty)
export GPG_TTY

# System binaries
PATH="/usr/local/bin:$PATH"
# Local binaries
if ! [[ "$PATH" =~ $HOME/.local/bin: ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH

# Zsh functions
if [ -f /opt/homebrew/bin/brew ]; then
    fpath+="$(brew --prefix)/share/zsh/site-functions"
fi
