# ~/.bashrc
#
# Necessary:
#  - bash, starship, vim(or gvim)
#  - zoxide, fzf, eza, yazi
#
# Optional but useful:
#  - bat, helix, rsync, neovim, fastfetch, lazygit

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

# -- system commands
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

#-- try to activate homebrew
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

#-- init apps
eval "$(starship init bash)"
eval "$(zoxide init bash --cmd cd)"
eval "$(fzf --bash)"

# config yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

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
BASH_CONFIG="~/.bashrc"
alias vibash="vi $BASH_CONFIG"
alias nvbash="nv $BASH_CONFIG"
alias hxbash="hx $BASH_CONFIG"
alias catbash="cat $BASH_CONFIG"
alias batbash="bat $BASH_CONFIG"

ZSH_CONFIG="~/.zshrc"
alias vizsh="vi $ZSH_CONFIG"
alias nvzsh="nv $ZSH_CONFIG"
alias hxzsh="hx $ZSH_CONFIG"
alias catzsh="cat $ZSH_CONFIG"
alias batzsh="bat $ZSH_CONFIG"

FISH_CONFIG="~/.config/fish/config.fish"
alias vifish="vi $FISH_CONFIG"
alias nvfish="nv $FISH_CONFIG"
alias hxfish="hx $FISH_CONFIG"
alias catfish="cat $FISH_CONFIG"
alias batfish="bat $FISH_CONFIG"

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
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# nodejs
export FNM_NODE_DIST_MIRROR="https://npmmirror.com/mirrors/node/"
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell bash)"
fi

# go
export GOPROXY="https://mirrors.tencent.com/go/"

#-- functions
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
  rm -rf ~/.claude/{cache,debug,projects,shell-snapshots,statsig,telemetry,todos,file-history,plans,history.jsonl,session-env}
  echo "claude history cleared."
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
