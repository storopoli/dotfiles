# brew install bash-completion zsh-completions zsh-autosuggestions zsh-syntax-highlighting
# brew install fzf gnupg pinentry-mac
# brew rustup nvm juliaup poetry yt-dlp lazygit gh
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
HISTFILE=~/.zsh_history
SAVEHIST=1000000
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_VERIFY               # Don't execute immediately upon history expansion

# Basic auto/tab complete:
autoload -Uz compinit select-word-style
select-word-style bash
zstyle ':completion:*' menu select, use-cache 1
zstyle ':autocomplete:*' fzf-completion yes
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Alt + left/right
# check out: https://superuser.com/a/1307657
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
# Alt + backspace
bindkey '^[^?' backward-kill-word

# User specific environment variables
export JULIA_NUM_THREADS=auto
alias ls='ls --color=auto'

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath+=/opt/homebrew/share/zsh/site-functions


# rustup
source "$HOME/.cargo/env"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Zsh Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh