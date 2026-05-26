# ~/.zshrc
#
# Necessary:
#  - zsh, zimfw, vim(or gvim)
#  - zoxide, fzf, eza, yazi, lazygit, jq
#
# Optional but useful:
#  - bat, helix, rsync, neovim, fastfetch, lazygit, jujutsu, task

# Reference:
#   - https://www.bilibili.com/video/BV1fdTfzeE8X/

#-- init zimfw
if [[ -f "/usr/share/zimfw/zimfw.zsh" ]]; then
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

#-- helper functions

# Prepend directories to PATH if not already present
function prepend_path() {
    local dir
    for dir in "$@"; do
        case ":$PATH:" in
        *":$dir:"*) ;;
        *) export PATH="$dir:$PATH" ;;
        esac
    done
}

# rm_except: remove all files and directories in the current directory except specified ones
function rm_except() {
    local yes=0
    local dry=0
    local -a keep=()

    # Parse command line arguments
    for arg in "$@"; do
        if [[ "$arg" == "-y" || "$arg" == "--yes" ]]; then
            yes=1
        elif [[ "$arg" == "--dry-run" ]]; then
            dry=1
        else
            # Clean leading ./ and trailing /
            clean=${arg#./}
            clean=${clean%/}
            [[ -n "$clean" ]] && keep+=("$clean")
        fi
    done

    # Show usage if no items to keep are provided
    if [ ${#keep[@]} -eq 0 ]; then
        echo "Usage: rm_except [-y|--yes] [--dry-run] item1 [item2 ...]"
        echo "       Supports brace expansion: rm_except ./{file1,file2,dir}"
        echo "       Also supports paths: rm_except subdir/keep.txt"
        echo "Example: rm_except important.txt myproject .git"
        echo "         rm_except -y ./{.git,README.md,docs}"
        return 1
    fi

    echo "=== Items to KEEP ==="
    printf '  %s\n' "${keep[@]}"

    echo -e "\n=== Items that WILL BE DELETED ==="

    # Build exclusion conditions
    local -a exclude=()
    for k in "${keep[@]}"; do
        if [[ "$k" == */* ]]; then
            exclude+=(-o -wholename "./$k")
        else
            exclude+=(-o -name "$k")
        fi
    done

    # Show what will be deleted
    find . -mindepth 1 -maxdepth 1 ! \( "${exclude[@]:1}" \) -print | sort

    # Dry-run mode: only show preview, do not delete anything
    if [ $dry -eq 1 ]; then
        echo -e "\nDry-run completed. No files were deleted."
        return 0
    fi

    # Ask for confirmation unless -y is used
    if [ $yes -eq 0 ]; then
        read "confirm?Confirm deletion? (y/N): "
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            echo "Cancelled."
            return 0
        fi
    else
        echo "Force mode (-y): proceeding with deletion..."
    fi

    # Perform the actual deletion
    find . -mindepth 1 -maxdepth 1 ! \( "${exclude[@]:1}" \) -exec rm -rf {} +
    echo "Deletion completed."
}

#-- try to activate homebrew
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

#-- init apps
eval "$(zoxide init zsh --cmd cd)"
source <(fzf --zsh)

# config yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# jujutsu completion
if command -v jj >/dev/null 2>&1; then
    source <(COMPLETE=zsh jj)
fi

#-- aliases
# editor aliases
alias vi="vim"
alias nv="nvim"
alias hx="helix"

# command abbrs
alias fa="fastfetch"
alias lg="lazygit"
alias reboot="systemctl reboot"
alias grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# configs shortcuts
ZSH_CONFIG="~/.zshrc"
alias vizsh="vi $ZSH_CONFIG"
alias nvzsh="nv $ZSH_CONFIG"
alias hxzsh="hx $ZSH_CONFIG"
alias catzsh="cat $ZSH_CONFIG"
alias batzsh="bat $ZSH_CONFIG"

ZSH_CONFIG="~/.zimrc"
alias vizim="vi $ZSH_CONFIG"
alias nvzim="nv $ZSH_CONFIG"
alias hxzim="hx $ZSH_CONFIG"
alias catzim="cat $ZSH_CONFIG"
alias batzim="bat $ZSH_CONFIG"

BASH_CONFIG="~/.bashrc"
alias vibash="vi $BASH_CONFIG"
alias nvbash="nv $BASH_CONFIG"
alias hxbash="hx $BASH_CONFIG"
alias catbash="cat $BASH_CONFIG"
alias batbash="bat $BASH_CONFIG"

FISH_CONFIG="~/.config/fish/config.fish"
alias vifish="vi $FISH_CONFIG"
alias nvfish="nv $FISH_CONFIG"
alias hxfish="hx $FISH_CONFIG"
alias catfish="cat $FISH_CONFIG"
alias batfish="bat $FISH_CONFIG"

# niri
if command -v niri >/dev/null 2>&1; then
    NIRI_CONFIG="~/.config/niri/config.kdl"
    alias viniri="vi $NIRI_CONFIG"
    alias nvniri="nv $NIRI_CONFIG"
    alias hxniri="hx $NIRI_CONFIG"
    alias catniri="cat $NIRI_CONFIG"
    alias batniri="bat $NIRI_CONFIG"

    NIRI_DIR="~/.config/niri/"
    alias cdniri="cd $NIRI_DIR"
fi

# task
if command -v go-task >/dev/null 2>&1 && ! command -v task >/dev/null 2>&1; then
    alias task='go-task'
fi

# zed
if command -v zeditor >/dev/null 2>&1 && ! command -v zed >/dev/null 2>&1; then
    alias zed='zeditor --classic'
fi

#-- alias functions
function ls() {
    eza --icons --git -a $@
}

function rsyncp() {
    rsync -alvhP $@
}

#-- lang & mirrors
# homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"

# rust
export RUSTUP_DIST_SERVER="https://mirrors.cernet.edu.cn/rustup"
export RUSTUP_UPDATE_ROOT="https://mirrors.cernet.edu.cn/rustup/rustup"
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

# go
export GOPROXY="https://mirrors.tencent.com/go/"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
prepend_path $PNPM_HOME

# bun
export BUN_BIN_DIR="$HOME/.bun/bin"
prepend_path $BUN_BIN_DIR

# -- Functions

# load .env file
# usage:
#   load_dotenv                # loads ~/.env
#   load_dotenv /path/to/.env  # loads custom file
function load_dotenv() {
    # Create a protected local zsh environment, silencing xtrace/verbose
    emulate -L zsh
    setopt localoptions no_xtrace no_verbose

    local file="${1:-$HOME/.env}"
    if [[ ! -f "$file" ]]; then
        echo "load_dotenv: $file not found" >&2
        return 1
    fi

    while IFS= read -r line || [[ -n "$line" ]]; do
        # Trim leading/trailing whitespace
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"

        # Skip empty lines and comments
        [[ -z "$line" || "$line" == '#'* ]] && continue

        local key="${line%%=*}"
        local value="${line#*=}"

        # Trim whitespace around key
        key="${key#"${key%%[![:space:]]*}"}"
        key="${key%"${key##*[![:space:]]}"}"
        [[ -z "$key" ]] && continue

        # Strip surrounding quotes (single or double)
        case "$value" in
        \'*\') value="${value:1:-1}" ;;
        \"*\") value="${value:1:-1}" ;;
        esac

        # Export variable, suppressing errors for invalid names
        typeset -gx "$key"="$value" 2>/dev/null
    done <"$file"
}
if [[ -f "~/.env" ]]; then
    load_dotenv
fi

# proxy functions
function set_proxy() {
    proxy_url="127.0.0.1:7890"
    http_proxy="http://$proxy_url"

    echo "proxy_url: $proxy_url"

    export ALL_PROXY=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy

    git config --global http.proxy $http_proxy
    git config --global https.proxy $http_proxy
}

function unset_proxy() {
    unset ALL_PROXY
    unset HTTP_PROXY
    unset HTTPS_PROXY

    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

# clean claude-code history
function clear_claude() {
    # clear cache directory
    set WORKDIR $PWD
    cd ~/.claude
    rm_except -y settings.json config.json .credentials.json plugins/ skills/
    cd $WORKDIR
    # overwrite .claude.json
    if command -v jq >/dev/null 2>&1; then
        jq '{hasCompletedOnboarding, mcpServers}' ~/.claude.json >~/.claude.tmp.json
        mv ~/.claude.tmp.json ~/.claude.json
        echo 'Overwrite ~/.claude.json'
    else
        echo "command $(jq) not found. ~/.claude.json was unchanged."
    fi

    # finish
    echo "claude history cleared."
}

# clean pi history
function clear_pi() {
    set WORKDIR $PWD
    # clear ~/.pi cache
    cd ~/.pi
    rm_except -y agent/ extensions/
    echo ""
    # clear ~/.pi/agent cache
    cd ~/.pi/agent/
    rm_except -y auth.json settings.json npm/
    # finish
    cd $WORKDIR
    echo "pi history cleared."
 c}

# clean codex history
function clear_codex() {
    set WORKDIR $PWD
    cd ~/.codex
    rm_except -y auth.json config.toml skills/
    cd $WORKDIR
    echo "codex history cleared."
}

# UU加速器
function start_uu() {
    sudo systemctl start uuplugin
    echo "UU加速器已开启"
}

function stop_uu() {
    sudo systemctl stop uuplugin
    echo "UU加速器已关闭"
}

# -- Zsh-specific
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
