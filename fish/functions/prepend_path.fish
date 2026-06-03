# prepend_path - Prepend directories to PATH if missing
# Usage: prepend_path dir1 [dir2 ...]
# 
# The function adds each given directory to the beginning of PATH
# only if it's not already present. It only affects the current session.
function prepend_path
    for dir in $argv
        if not contains -- $dir $PATH
            set -gx PATH $dir $PATH
        end
    end
end
