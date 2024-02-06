# Enable colors and change prompt:
autoload -U colors && colors # Load colors
autoload -U promptinit
promptinit
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
stty stop undef # Disable ctrl-s to freeze terminal.
setopt extendedglob

# LANG Stuff
export LANG=en
export LC_ALL=en_US.UTF-8

# History
HISTSIZE=1000000
HISTFILE=~/.bash_history
SAVEHIST=1000000
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_VERIFY               # Don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY        # Save history on every command not shell exit

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

# VIM keybindings
bindkey -v

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
alias yt="yt-dlp --add-metadata -i --format mp4 --restrict-filenames"
alias yta="yt -x -f bestaudio/best --format mp4 --audio-format opus --restrict-filenames"

# brew
if [ -f /opt/homebrew/bin/brew ]; then
  brew_prefix=$(/opt/homebrew/bin/brew --prefix)
  eval "$($brew_prefix/bin/brew shellenv)"
fi

# GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)

# System binaries
PATH="/usr/local/bin:$PATH"
# Local binaries
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]
then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH

# Zsh functions
fpath+="$(brew --prefix)/share/zsh/site-functions"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Zoxide
eval "$(zoxide init zsh)"

# rustup
source "$HOME/.cargo/env"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# yazi
function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Zsh Plugins
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  elif [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
  else
    echo "zsh-autosuggestions not found"
fi
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  elif [ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  else
    echo "zsh-syntax-highlighting not found"
fi
