# ~/.bash/bash_aliases.sh

source "$HOME/.bash/bash_functions.sh"

#
# -- system commands
#
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

#
#-- aliases & abbrs
#
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
BASH_CONFIG="$HOME/.bashrc"
alias vibash="vi $BASH_CONFIG"
alias nvbash="nv $BASH_CONFIG"
alias hxbash="hx $BASH_CONFIG"
alias catbash="cat $BASH_CONFIG"
alias batbash="bat $BASH_CONFIG"

ZSH_CONFIG="$HOME/.zshrc"
alias vizsh="vi $ZSH_CONFIG"
alias nvzsh="nv $ZSH_CONFIG"
alias hxzsh="hx $ZSH_CONFIG"
alias catzsh="cat $ZSH_CONFIG"
alias batzsh="bat $ZSH_CONFIG"

FISH_CONFIG="$HOME/.config/fish/config.fish"
alias vifish="vi $FISH_CONFIG"
alias nvfish="nv $FISH_CONFIG"
alias hxfish="hx $FISH_CONFIG"
alias catfish="cat $FISH_CONFIG"
alias batfish="bat $FISH_CONFIG"

#
#-- command aliases
#
# task
if command_exists go-task && ! command_exists task; then
    alias task="go-task"
fi

# zed
if command_exists zeditor && ! command_exists zed; then
    alias zed='zeditor --classic'
fi

#
#-- alias functions
#
function ls() {
    command_exists eza && eza --icons --git -a "$@"
}

rsyncp() {
    rsync -alvhP "$@"
}
