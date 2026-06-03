# ~/.bashrc
#
# Necessary:
#  - bash, starship, vim(or gvim)
#  - zoxide, fzf, eza, yazi, jq
#
# Optional but useful:
#  - bat, helix, rsync, neovim, fastfetch, lazygit, jujutsu, task

#
#-- Imports
#
# Load configs in `~/.bash/`
source "$HOME/.bash/bash_functions.sh"
source "$HOME/.bash/bash_env.sh"
source "$HOME/.bash/bash_aliases.sh"

# Add `~/.bash/bin/` to PATH, which contains custom commands
SCRIPTS_DIR="$HOME/.bash/bin/"
[ -d $SCRIPTS_DIR ] && prepend_path $SCRIPTS_DIR || echo "Warning: $SCIRPTS_DIR not exists!"

# load ~/.env
[[ -f ~/.env ]] && load_dotenv

#
#-- Shell configs
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt format
PS1='[\u@\h \W]\$ '

# history related settings
## ignore duplicate lines and space in the history.
HISTCONTROL=ignoredups:ignorespace

## append to the history file, don't overwrite it
shopt -s histappend

## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50
HISTFILESIZE=100

#
#-- try to activate homebrew
#
BREW_CMD="/home/linuxbrew/.linuxbrew/bin/brew"
[[ -x $BREW_CMD ]] && eval "$(BREW_CMD shellenv)"

#
#-- Init apps
#
command_exists starship && eval "$(starship init bash)"
command_exists zoxide && eval "$(zoxide init bash --cmd cd)"
command_exists fzf && eval "$(fzf --bash)"

# config yazi
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# jujutsu completion
command_exists jj && source <(COMPLETE=bash jj)

#
#-- Language
#
# rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# pnpm
if [ -d "$HOME/.local/share/pnpm" ]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    prepend_path "$PNPM_HOME"
fi

# bun
if [ -d "$HOME/.bun/bin" ]; then
    export BUN_BIN_DIR="$HOME/.bun/bin"
    prepend_path "$BUN_BIN_DIR"
fi
