# ~/.zshrc
#
# Necessary: 
#  - zsh, zimfw, vim
#  - zoxide, fzf, eza, yazi, lazygit
#
# Optional but useful:
#  - bat, helix, rsync


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



# -- General Configs

# startup apps
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# more aliases
alias vi="vim"
alias hx="helix"
alias ls="eza --icons --git -a"
alias cd="z"
alias rsyncp="rsync -alvhP"

alias vizsh="vim ~/.zshrc"
alias hxzsh="hx ~/.zshrc"
alias catzsh="cat ~/.zshrc"
alias batzsh="bat ~/.zshrc"

alias vizim="vim ~/.zimrc"
alias hxzim="hx ~/.zimrc"
alias catzim="cat ~/.zimrc"
alias batzim="bat ~/.zimrc"

alias vibash="vim ~/.bashrc"
alias hxbash="hx ~/.bashrc"
alias catbash="cat ~/.bashrc"
alias batbash="bat ~/.bashrc"

alias vifish="vim ~/.config/fish/config.fish"
alias hxfish="hx ~/.config/fish/config.fish"
alias catfish="cat ~/.config/fish/config.fish"
alias batfish="bat ~/.config/fish/config.fish"


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


# config yazi
function y() {
    local tmp
    tmp=$(mktemp -t "yazi-cwd.XXXXXX")
    yazi "$@" --cwd-file="$tmp"
    if read -r -z cwd < "$tmp" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
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


# Other functions
function clear_claude() {
    rm -rf ~/.claude/{cache,debug,projects,shell-snapshots,statsig,telemetry,todos,file-history,plans,history.jsonl,session-env}
    echo "claude history cleared."
}



# -- Zsh-specific

# Set lazygit keybinding
function lazygit_widget() {
    lazygit
    zle reser-prompt
}

zle -N lazygit_widget
bindkey '^g' lazygit_widget


