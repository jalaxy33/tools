# ~/.zshrc
#
# Necessary: 
#  - zsh, zimfw, vim
#  - zoxide, fzf, eza, yazi, lazygit
#
# Optional but useful:
#  - bat, helix, rsync, neovim


# Reference:
#   - https://www.bilibili.com/video/BV1fdTfzeE8X/


# -- zimfw 

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source /usr/share/zimfw/zimfw.zsh init
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# Modules configuration
ZSH_AUTOSUGGEST_MANUAL_REBIND=1


# -- Homebrew init

# try to activate homebrew
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# -- General Configs

# startup apps
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# aliases
alias vi="vim"
alias nv="nvim"
alias hx="helix"
alias ls="eza --icons --git -a"
alias cd="z"
alias rsyncp="rsync -alvhP"

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


# niri aliases
if command -v niri >/dev/null 2>&1; then
    NIRI_CONFIG="~/.config/niri/config.kdl"
    alias vizsh="vi $ZSH_CONFIG"
    alias nvzsh="nv $ZSH_CONFIG"
    alias hxzsh="hx $ZSH_CONFIG"
    alias catzsh="cat $ZSH_CONFIG"
    alias batzsh="bat $ZSH_CONFIG"
fi


# Homebrew mirror
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"


# config rust
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi


# config nodejs
export FNM_NODE_DIST_MIRROR="https://npmmirror.com/mirrors/node/"
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# config go
export GOPROXY="https://mirrors.tencent.com/go/"


# -- Functions

# config yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}


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


# other functions
function clear_claude() {
    rm -rf ~/.claude/{cache,debug,projects,shell-snapshots,statsig,telemetry,todos,file-history,plans,history.jsonl,session-env}
    echo "claude history cleared."
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

