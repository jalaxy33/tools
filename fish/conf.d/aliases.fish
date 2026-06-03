# ~/.config/fish/conf.d/aliases.fish
#
# Command aliases
#

#
#-- aliases & abbrs
#
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
set BASH_CONFIG "$HOME/.bashrc"
alias vibash="vi $BASH_CONFIG"
alias nvbash="nv $BASH_CONFIG"
alias hxbash="hx $BASH_CONFIG"
alias catbash="cat $BASH_CONFIG"
alias batbash="bat $BASH_CONFIG"

set ZSH_CONFIG "$HOME/.zshrc"
alias vizsh="vi $ZSH_CONFIG"
alias nvzsh="nv $ZSH_CONFIG"
alias hxzsh="hx $ZSH_CONFIG"
alias catzsh="cat $ZSH_CONFIG"
alias batzsh="bat $ZSH_CONFIG"

set FISH_CONFIG "$HOME/.config/fish/config.fish"
alias vifish="vi $FISH_CONFIG"
alias nvfish="nv $FISH_CONFIG"
alias hxfish="hx $FISH_CONFIG"
alias catfish="cat $FISH_CONFIG"
alias batfish="bat $FISH_CONFIG"

#
#-- command aliases
#
# task
if command -q go-task; and not command -q task
    alias task='go-task'
end

# zed
if command -q zeditor; and not command -q zed
    alias zed='zeditor --classic'
end

#
#-- alias functions
#
function ls
    command -q eza && command eza --icons --git -a $argv
end

function rsyncp
    command rsync -alvhP $argv
end
