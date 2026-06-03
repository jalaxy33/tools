# unset_proxy - Unset HTTP/HTTPS proxy environment variables and git proxy settings
# Usage: unset_proxy
function unset_proxy --description "Unset HTTP/HTTPS proxy and git proxy settings"
    # Unset environment variables
    set -ge ALL_PROXY HTTP_PROXY HTTPS_PROXY

    # Remove git proxy settings (suppress errors if not set)
    git config --global --unset http.proxy 2>/dev/null
    git config --global --unset https.proxy 2>/dev/null

    echo "Proxy unset."
end
