# ~/.config/fish/conf.d/env.fish
#
# Setting environment variables for fish
#

#
#-- mirrors
#
# homebrew
set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
set -x HOMEBREW_CORE_GIT_REMOTE "https://mirrors.ustc.edu.cn/homebrew-core.git"
set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
set -x HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"

# rust
set -x RUSTUP_DIST_SERVER "https://mirrors.cernet.edu.cn/rustup"
set -x RUSTUP_UPDATE_ROOT "https://mirrors.cernet.edu.cn/rustup/rustup"

# go
set -x GOPROXY "https://mirrors.tencent.com/go/"
