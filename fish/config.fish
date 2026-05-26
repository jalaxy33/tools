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
#  - zoxide, fzf, eza, yazi, jq
#
# Optional but useful:
#  - bat, helix, rsync, neovim, fastfetch, lazygit, jujutsu, task

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""
#set -p PATH ~/.local/bin

#-- helper functions

function prepend_path -d "Prepend a directory to PATH if not already present"
    for dir in $argv
        if not contains $dir $PATH
            set -gx PATH $dir $PATH
        end
    end
end

function rm_except --description 'Safe delete all except specified items'
    set -l yes 0
    set -l dry 0
    set -l keep

    for arg in $argv
        if test "$arg" = -y -o "$arg" = --yes
            set yes 1
        else if test "$arg" = --dry-run
            set dry 1
        else
            set clean (string replace -r '^\./' '' -- $arg | string replace -r '/$' '')
            if test -n "$clean"
                set -a keep $clean
            end
        end
    end

    if test (count $keep) -eq 0
        echo "Usage: rm_except [-y|--yes] [--dry-run] item1 [item2 ...]"
        echo "       Example: rm_except ./{.git,important.txt,myproject} subdir/keep.log"
        return 1
    end

    echo "=== Items to KEEP ==="
    for k in $keep
        echo "  $k"
    end

    echo -e "\n=== Items that WILL BE DELETED ==="

    set -l exclude
    for k in $keep
        if string match -q '*/*' -- $k
            set -a exclude -o -wholename "./$k"
        else
            set -a exclude -o -name "$k"
        end
    end

    find . -mindepth 1 -maxdepth 1 ! \( $exclude[2..] \) -print | sort

    if test $dry -eq 1
        echo -e "\nDry-run completed. No files were deleted."
        return 0
    end

    if test $yes -eq 0
        read --prompt-str "Confirm deletion? (y/N): " confirm
        if not string match -qi y -- $confirm
            echo "Cancelled."
            return 0
        end
    else
        echo "Force mode (-y): proceeding..."
    end

    find . -mindepth 1 -maxdepth 1 ! \( $exclude[2..] \) -exec rm -rf {} +
    echo "Deletion completed."
end

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

# jujutsu completion
if command -q jj
    COMPLETE=fish jj | source
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

# niri
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

# task
if command -q go-task; and not command -q task
    alias task='go-task'
end

# zed
if command -q zeditor; and not command -q zed
    alias zed='zeditor --classic'
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
set -x RUSTUP_DIST_SERVER "https://mirrors.cernet.edu.cn/rustup"
set -x RUSTUP_UPDATE_ROOT "https://mirrors.cernet.edu.cn/rustup/rustup"
if test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end

# go
set -x GOPROXY "https://mirrors.tencent.com/go/"

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
prepend_path $PNPM_HOME

# bun
set -gx BUN_BIN_DIR "$HOME/.bun/bin"
prepend_path $BUN_BIN_DIR

#-- functions

# load .env file
# usage:
#   load_dotenv                # loads ~/.env
#   load_dotenv /path/to/.env  # loads custom file
function load_dotenv --description "Load environment variables from .env file"
    set -l file $argv[1]
    if test -z "$file"
        set file "$HOME/.env"
    end

    if not test -f "$file"
        echo "load_dotenv: $file not found" >&2
        return 1
    end

    while read -l line
        # Trim whitespace
        set line (string trim "$line")

        # Skip empty lines and comments
        if test -z "$line"; or string match -q '#*' "$line"
            continue
        end

        # Split key and value
        set -l key (string split -m1 = "$line")[1]
        set -l value (string split -m1 = "$line")[2]

        # Trim whitespace from key
        set key (string trim "$key")
        if test -z "$key"
            continue
        end

        # Strip surrounding single or double quotes
        if string match -q "'*'" "$value"
            set value (string sub -s 2 -e -1 "$value")
        else if string match -q '"*"' "$value"
            set value (string sub -s 2 -e -1 "$value")
        end

        # Export to environment
        set -gx "$key" "$value"
    end <"$file"
end
if test -e ~/.env
    load_dotenv
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

# clean claude-code history
function clear_claude
    # clear cache directory
    set WORKDIR $PWD
    cd ~/.claude
    rm_except -y settings.json config.json .credentials.json plugins/ skills/
    cd $WORKDIR
    # overwrite .claude.json
    if command -q jq
        jq '{hasCompletedOnboarding, mcpServers}' ~/.claude.json >~/.claude.tmp.json
        mv ~/.claude.tmp.json ~/.claude.json
        echo 'Overwrite ~/.claude.json'
    else
        echo "command `jq` not found. ~/.claude.json was unchanged."
    end
    # finish
    echo "claude history cleared."
end

# clean pi history
function clear_pi
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
end

# clean codex history
function clear_codex
    set WORKDIR $PWD
    cd ~/.codex
    rm_except -y auth.json config.toml skills/
    cd $WORKDIR
    echo "codex history cleared."
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
