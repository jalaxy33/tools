# set_proxy - Set HTTP/HTTPS proxy with optional host and port
# Usage: set_proxy [host[:port]] [port]
#   - No args:         default 127.0.0.1:7890
#   - host:port        e.g. set_proxy 192.168.1.1:8080
#   - host [port]      e.g. set_proxy proxy.example.com 3128
function set_proxy --description "Set HTTP/HTTPS proxy"
    # Default host and port
    set -l host 127.0.0.1
    set -l port 7890

    # Parse arguments
    switch (count $argv)
        case 0
            # Use defaults
        case 1
            if string match -q '*:*' -- $argv[1]
                set host (string split -m1 : -- $argv[1])[1]
                set port (string split -m1 : -- $argv[1])[2]
            else
                set host $argv[1]
            end
        case 2
            set host $argv[1]
            set port $argv[2]
        case '*'
            echo "Usage: set_proxy [host[:port]] [port]" >&2
            return 1
    end

    set -l proxy_url "$host:$port"
    set -l http_proxy "http://$proxy_url"

    echo "proxy_url: $proxy_url"

    # Export environment variables
    set -gx ALL_PROXY $http_proxy
    set -gx HTTP_PROXY $http_proxy
    set -gx HTTPS_PROXY $http_proxy

    # Configure git proxy globally
    git config --global http.proxy $http_proxy
    git config --global https.proxy $http_proxy
end
