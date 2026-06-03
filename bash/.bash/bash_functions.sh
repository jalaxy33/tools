# ~/.bash/bash_functions.sh

#
#-- helper functions
#
# command_exists - check if a command exists
# Usage: command_exists <command_name>
# Returns: 0 if command exists, 1 if not, 2 if argument missing
command_exists() {
    if [ $# -ne 1 ]; then
        echo "Usage: command_exists <command_name>" >&2
        return 2
    fi
    command -v "$1" >/dev/null 2>&1
}

# prepend_path - Prepend dirs to PATH if missing;
#  usage: prepend_path dir1 [dir2...]
prepend_path() {
    local dir
    for dir in "$@"; do
        [[ ":$PATH:" == *":$dir:"* ]] || PATH="$dir:$PATH"
    done
    export PATH
}

# load .env file
# usage:
#   load_dotenv                # loads ~/.env
#   load_dotenv /path/to/.env  # loads custom file
#   load_dotenv /path/to/.env --no-override  # do not override existing env vars
load_dotenv() {
    local file="${1:-$HOME/.env}"
    local no_override=false
    local has_error=0

    if [[ "$2" == "--no-override" ]]; then
        no_override=true
    fi

    if [[ ! -f "$file" ]]; then
        echo "load_dotenv: $file not found" >&2
        return 1
    fi

    # Flag to handle BOM on first line only
    local bom_handled=0

    while IFS= read -r line || [[ -n "$line" ]]; do
        # ---------- 1. Handle UTF-8 BOM on first line ----------
        if ((bom_handled == 0)); then
            bom_handled=1
            # Remove BOM if present (three bytes: \xEF\xBB\xBF)
            if [[ "$line" == $'\xEF\xBB\xBF'* ]]; then
                line="${line:3}"
            fi
        fi

        # ---------- 2. Trim leading/trailing whitespace (POSIX-friendly) ----------
        # Remove leading whitespace
        local leading="${line%%[![:space:]]*}"
        line="${line#$leading}"
        # Remove trailing whitespace
        local trailing="${line##*[![:space:]]}"
        line="${line%$trailing}"

        # ---------- 3. Skip empty lines and comments ----------
        if [[ -z "$line" ]] || [[ "$line" == "#"* ]]; then
            continue
        fi

        # ---------- 4. Handle optional 'export' prefix ----------
        if [[ "$line" =~ ^export[[:space:]]+(.*) ]]; then
            # Remove 'export' and any following spaces
            line="${line#export}"
            # Trim again (left whitespace)
            local exp_leading="${line%%[![:space:]]*}"
            line="${line#$exp_leading}"
        fi

        # ---------- 5. Skip lines without '=' ----------
        if [[ "$line" != *"="* ]]; then
            echo "load_dotenv: skipping invalid line (no '='): $line" >&2
            has_error=1
            continue
        fi

        # ---------- 6. Split into key and value ----------
        local key="${line%%=*}"
        local value="${line#*=}"

        # Trim key (again, after potential spaces around '=')
        local key_leading="${key%%[![:space:]]*}"
        key="${key#$key_leading}"
        local key_trailing="${key##*[![:space:]]}"
        key="${key%$key_trailing}"

        if [[ -z "$key" ]]; then
            echo "load_dotenv: skipping empty key in line: $line" >&2
            has_error=1
            continue
        fi

        # ---------- 7. Strip matching quotes from value ----------
        if [[ "$value" == \'*\' && "${#value}" -ge 2 ]]; then
            # Single quotes
            value="${value:1:${#value}-2}"
        elif [[ "$value" == \"*\" && "${#value}" -ge 2 ]]; then
            # Double quotes
            value="${value:1:${#value}-2}"
        fi

        # ---------- 8. Optionally skip if variable already exists ----------
        if [[ "$no_override" == true ]] && [[ -n "${!key}" ]]; then
            continue
        fi

        # ---------- 9. Export the variable ----------
        export "$key"="$value"
    done <"$file"

    return $has_error
}

#
#-- proxy functions
#
# set_proxy - Set HTTP/HTTPS proxy with optional host and port
# Usage: set_proxy [host[:port]] [port]
#   - No args:         default 127.0.0.1:7890
#   - host:port        e.g. set_proxy 192.168.1.1:8080
#   - host [port]      e.g. set_proxy proxy.example.com 3128
set_proxy() {
    local host="127.0.0.1"
    local port="7890"

    case $# in
    0)
        ;;
    1)
        if [[ "$1" == *:* ]]; then
            host="${1%:*}"
            port="${1#*:}"
        else
            host="$1"
        fi
        ;;
    2)
        host="$1"
        port="$2"
        ;;
    *)
        echo "Usage: set_proxy [host[:port]] [port]" >&2
        return 1
        ;;
    esac

    local proxy_url="$host:$port"
    local http_proxy="http://$proxy_url"

    echo "proxy_url: $proxy_url"

    export ALL_PROXY="$http_proxy"
    export HTTP_PROXY="$http_proxy"
    export HTTPS_PROXY="$http_proxy"

    git config --global http.proxy "$http_proxy"
    git config --global https.proxy "$http_proxy"
}

# unset_proxy - Unset HTTP/HTTPS proxy environment variables and git proxy settings
# Usage: unset_proxy
unset_proxy() {
    unset ALL_PROXY HTTP_PROXY HTTPS_PROXY
    git config --global --unset http.proxy 2>/dev/null
    git config --global --unset https.proxy 2>/dev/null
    echo "Proxy unset."
}
