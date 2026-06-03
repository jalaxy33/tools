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
