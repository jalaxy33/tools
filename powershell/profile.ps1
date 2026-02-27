# profile.ps1 or Microsoft.PowerShell_profile.ps1
#    powershell 7: ~/Document/PowerShell
#    older version: ~/Document/WindowsPowerShell


# [Necessary!!!] install `scoop`
#   might be helpful: https://github.com/lzwme/scoop-proxy-cn


# Necessary apps:
#   7zip git
#   starship scoop-search zoxide eza 
#   yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick


# Recommended Nerd Font:
#   `Mapple-Mono-NF-CN` or `JetBrainsMono-NF-Mono`


# [Hint] create soft link by: 
#    New-Item -ItemType SymbolicLink -Path "C:\Path\To\Link" -Target "C:\Path\To\Original" 


## --- Help functions ---

function Command-Exist {
    param(
        [string]$name
    )
    Get-Command $name -ErrorAction SilentlyContinue
}


## --- shell behaviors ---

# make tab completion using /
# Reference: 
#  - https://www.bilibili.com/video/BV1B2421K7Qo/
#  - https://github.com/PowerShell/PSReadLine/issues/3205
# PSReadLine is required： https://github.com/PowerShell/PSReadLine
Set-PSReadLineKeyHandler -Chord Tab -ScriptBlock {
  $content = ""
  $index = 0

  [Microsoft.PowerShell.PSConsoleReadLine]::ViTabCompleteNext()
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref] $content, [ref] $index)
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($content.Replace('\','/'))
  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($index)
}


## --- init apps ---

if (Command-Exist starship) { Invoke-Expression (&starship init powershell) }
if (Command-Exist scoop-search) { Invoke-Expression (&scoop-search --hook) }
if (Command-Exist zoxide) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }


## --- alias --- 

# pwsh config
if (Command-Exist vim) {
    function vipwsh { vim $PROFILE.CurrentUserAllHosts }
}

function catpwsh { cat $PROFILE.CurrentUserAllHosts }


# prettier ls
if (Command-Exist eza) {
    function eza-ls { eza -a --icons --git @args }
    Set-Alias -Name ls -Value eza-ls -Option AllScope
}

function ll { ls -l @args }

# smarter cd
if (Command-Exist zoxide) { Set-Alias -Name cd -Value z -Option AllScope }

# yazi
# scoop install yazi
# scoop install ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick
function y {
    $tmp = (New-TemporaryFile).FullName
    yazi.exe $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}



## --- set proxy ---

function set_proxy() {
    $proxy_url = "127.0.0.1:7890"
    $http_proxy = "http://$proxy_url"

    $env:HTTP_PROXY = $http_proxy
    $env:HTTPS_PROXY = $http_proxy

    if (Command-Exist git) {
        git config --global https.proxy $http_proxy
        git config --global https.proxy $http_proxy
    }
    

    if (Command-Exist scoop) {
        scoop config proxy $proxy_url
    }
}

function unset_proxy {
    if (Test-Path Env:HTTP_PROXY) {
        Remove-Item Env:HTTP_PROXY
        Remove-Item Env:HTTPS_PROXY
    }

    if (Command-Exist git) {
        git config --global --unset http.proxy
        git config --global --unset https.proxy
    }
    
    if (Command-Exist scoop) {
        scoop config rm proxy
    }
}


# -- claude
function clear_claude() {
    rm "$HOME\.claude\backups","$HOME\.claude\cache","$HOME\.claude\debug",`
        "$HOME\.claude\projects","$HOME\.claude\shell-snapshots",`
        "$HOME\.claude\statsig","$HOME\.claude\telemetry","$HOME\.claude\todos",`
        "$HOME\.claude\file-history","$HOME\.claude\plans",`
        "$HOME\.claude\history.jsonl","$HOME\.claude\session-env" `
        -r -fo -EA SilentlyContinue
}


## --- environment variables ---

# Editor
if (Command-Exist vim) { 
    $env:EDITOR = "vim"
}

# Rust
$env:RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env:RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"

# for yazi
#$env:YAZI_FILE_ONE = "C:\Scoop\GlobalScoopApps\apps\git\current\usr\bin\file.exe"

