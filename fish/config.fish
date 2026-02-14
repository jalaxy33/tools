# ~/.config/fish/config.fish
#
# Necessary:
#  - fish, starship, vim
#  - zoxide, fzf, eza, yazi
#
# Optional but useful:
#  - bat, helix, rsync, neovim


if status is-interactive
    set fish_greeting ""

    # try to activate homebrew
    if command -q /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end

    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    fzf --fish | source

    # aliases
    alias vi="vim"
    alias nv="nvim"
    alias hx="helix"
    alias ls="eza --icons --git -a"
    alias cd="z"
    alias rsyncp="rsync -alvhP"

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

    # niri alias
    if command -q niri
        set NIRI_CONFIG "~/.config/niri/config.kdl"
        alias vizsh="vi $ZSH_CONFIG"
        alias nvzsh="nv $ZSH_CONFIG"
        alias hxzsh="hx $ZSH_CONFIG"
        alias catzsh="cat $ZSH_CONFIG"
        alias batzsh="bat $ZSH_CONFIG"
    end

    # homebrew mirror
    set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
    set -x HOMEBREW_CORE_GIT_REMOTE "https://mirrors.ustc.edu.cn/homebrew-core.git"
    set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
    set -x HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"

    # config rust
    set -x RUSTUP_DIST_SERVER "https://rsproxy.cn"
    set -x RUSTUP_UPDATE_ROOT "https://rsproxy.cn/rustup"
    if test -f "$HOME/.cargo/env.fish"
        source "$HOME/.cargo/env.fish"
    end

    # config nodejs
    set -x FNM_NODE_DIST_MIRROR https://npmmirror.com/mirrors/node/
    if command -q fnm
        fnm env --use-on-cd --shell fish | source
    end

    # config go
    set -x GOPROXY "https://mirrors.tencent.com/go/"

end

# config yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end


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


# other functions
function clear_claude
    rm -rf ~/.claude/{cache,debug,projects,shell-snapshots,statsig,telemetry,todos,file-history,plans,history.jsonl,session-env}
    echo "claude history cleared."
end


