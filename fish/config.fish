# ~/.config/fish/config.fish
#
# ## File Structure
# ~/.config/fish/
# ├── conf.d/     # dir for auto-loaded configs
# ├── functions/  # dir for functions
# └── config.fish
#
# ## Softwares
# Necessary:
#  - fish, starship, vim(or gvim)
#  - zoxide, fzf, eza, yazi
#
# Optional but useful:
#  - bat, helix, rsync, neovim, fastfetch, lazygit

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""
set -p PATH ~/.local/bin

#-- try to activate homebrew
if command -q /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

#-- init apps
starship init fish | source
zoxide init fish --cmd cd | source
fzf --fish | source

# config yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

#-- aliases
# editor aliases
alias vi='vim'
alias nv='nvim'
alias hx='helix'

# command abbrs
abbr fa fastfetch
abbr lg lazygit
abbr reboot 'systemctl reboot'
abbr grub 'sudo grub-mkconfig -o /boot/grub/grub.cfg'

# configs shortcuts
set FISH_CONFIG "~/.config/fish/config.fish"
alias vifish="vi $FISH_CONFIG"
alias nvfish="nv $FISH_CONFIG"
alias hxfish="hx $FISH_CONFIG"
alias catfish="cat $FISH_CONFIG"
alias batfish="bat $FISH_CONFIG"

set BASH_CONFIG "~/.bashrc"
alias vibash="vi $BASH_CONFIG"
alias nvbash="nv $BASH_CONFIG"
alias hxbash="hx $BASH_CONFIG"
alias catbash="cat $BASH_CONFIG"
alias batbash="bat $BASH_CONFIG"

set ZSH_CONFIG "~/.zshrc"
alias vizsh="vi $ZSH_CONFIG"
alias nvzsh="nv $ZSH_CONFIG"
alias hxzsh="hx $ZSH_CONFIG"
alias catzsh="cat $ZSH_CONFIG"
alias batzsh="bat $ZSH_CONFIG"

if command -q niri
    set NIRI_CONFIG "~/.config/niri/config.kdl"
    alias viniri="vi $NIRI_CONFIG"
    alias nvniri="nv $NIRI_CONFIG"
    alias hxniri="hx $NIRI_CONFIG"
    alias catniri="cat $NIRI_CONFIG"
    alias batniri="bat $NIRI_CONFIG"

    set NIRI_DIR "~/.config/niri/"
    alias cdniri="cd $NIRI_DIR"
end

#-- alias functions
function ls
    command eza --icons --git -a $argv
end

function rsyncp
    command rsync -alvhP $argv
end

#-- lang & mirrors
# homebrew
set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
set -x HOMEBREW_CORE_GIT_REMOTE "https://mirrors.ustc.edu.cn/homebrew-core.git"
set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
set -x HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"

# rust
set -x RUSTUP_DIST_SERVER "https://rsproxy.cn"
set -x RUSTUP_UPDATE_ROOT "https://rsproxy.cn/rustup"
if test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end

# nodejs
set -x FNM_NODE_DIST_MIRROR "https://npmmirror.com/mirrors/node/"

# go
set -x GOPROXY "https://mirrors.tencent.com/go/"

#-- functions
# proxy functions
function set_proxy
    set proxy_url "127.0.0.1:7890"
    set http_proxy "http://$proxy_url"

    echo "proxy_url: $proxy_url"

    set -x ALL_PROXY $http_proxy
    set -x HTTP_PROXY $http_proxy
    set -x HTTPS_PROXY $http_proxy

    git config --global http.proxy $http_proxy
    git config --global https.proxy $http_proxy
end

function unset_proxy
    set -u ALL_PROXY
    set -u HTTP_PROXY
    set -u HTTPS_PROXY

    git config --global --unset http.proxy
    git config --global --unset https.proxy
end

# clean claude-code history
function clear_claude
    rm -rf ~/.claude/{cache,debug,projects,shell-snapshots,statsig,telemetry,todos,file-history,plans,history.jsonl,session-env}
    echo "claude history cleared."
end

# UU加速器
function start_uu
    sudo systemctl start uuplugin
    echo UU加速器已开启
end

function stop_uu
    sudo systemctl stop uuplugin
    echo UU加速器已关闭
end
