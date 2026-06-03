# ~/.zshrc
#
# Necessary:
#  - zsh, zimfw, vim(or gvim)
#  - zoxide, fzf, eza, yazi, lazygit, jq
#
# Optional but useful:
#  - bat, helix, rsync, neovim, fastfetch, lazygit, jujutsu, task
#
# Reference:
#   - https://www.bilibili.com/video/BV1fdTfzeE8X/

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
#-- init zimfw
#
if [[ -f "/usr/share/zimfw/zimfw.zsh" ]]; then
    [[ ! -f $HOME/.zimrc ]] && echo "Warning: $HOME/.zimrc not exist!"

    ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
    # Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
    if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
        source /usr/share/zimfw/zimfw.zsh init
    fi

    # Initialize modules.
    source ${ZIM_HOME}/init.zsh

    # Modules configuration
    ZSH_AUTOSUGGEST_MANUAL_REBIND=1
fi

#
#-- try to activate homebrew
#
BREW_CMD="/home/linuxbrew/.linuxbrew/bin/brew"
[[ -x $BREW_CMD ]] && eval "$(BREW_CMD shellenv)"

#
#-- Init apps
#
command_exists zoxide && eval "$(zoxide init zsh --cmd cd)"
command_exists fzf && source <(fzf --zsh)

# config yazi
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# jujutsu completion
command_exists jj && source <(COMPLETE=zsh jj)

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

#
#-- Zsh keybindings
#
# Set lazygit keybinding (crtl+g)
function lazygit_widget() {
    lazygit
    zle reset-prompt
}

zle -N lazygit_widget
bindkey '^g' lazygit_widget

# Set yazi keybinding (crtl+y)
function yazi_widget() {
    y
    zle reset-prompt
}

zle -N yazi_widget
bindkey '^y' yazi_widget

# Set nvim keybinding (alt+n)
function nvim_widget() {
    nvim
    zle reset-prompt
}

zle -N nvim_widget
bindkey '^[n' nvim_widget
