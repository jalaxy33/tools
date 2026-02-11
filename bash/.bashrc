# ~/.bashrc
#
# Necessary:
#  - bash, vim
#  - zoxide, fzf, eza, yazi
#
# Optional but useful:
#  - bat, helix, rsync, neovim


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


# color support
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'


# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# try to activate homebrew
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# startup apps
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(fzf --bash)"


# more aliases
alias vi="vim"
alias nv="nvim"
alias hx="helix"
alias ls="eza --icons --git -a"
alias cd="z"
alias rsyncp="rsync -alvhP"

alias vibash="vi ~/.bashrc"
alias nvbash="nv ~/.bashrc"
alias hxbash="hx ~/.bashrc"
alias catbash="cat ~/.bashrc"
alias batbash="bat ~/.bashrc"

alias vizsh="vi ~/.zshrc"
alias nvzsh="nv ~/.zshrc"
alias hxzsh="hx ~/.zshrc"
alias catzsh="cat ~/.zshrc"
alias batzsh="bat ~/.zshrc"

alias vifish="vi ~/.config/fish/config.fish"
alias nvfish="nv ~/.config/fish/config.fish"
alias hxfish="hx ~/.config/fish/config.fish"
alias catfish="cat ~/.config/fish/config.fish"
alias batfish="bat ~/.config/fish/config.fish"


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
    eval "$(fnm env --use-on-cd --shell bash)"
fi

# config go
export GOPROXY="https://mirrors.tencent.com/go/"


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


