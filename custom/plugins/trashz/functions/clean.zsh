function clean_trash() {
    local force=""
    local recursive=""
    local target="$HOME/.trash"

    # Parse options
    while getopts ":fr" opt; do
        case $opt in
            f)
                force="-f"
                ;;
            r)
                recursive="-r"
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                ;;
        esac
    done
    shift $((OPTIND - 1))

    # Formulate the command
    local cmd="/bin/rm"
    if [[ -n "$force" ]]; then
        cmd+=" $force"
    fi
    if [[ -n "$recursive" ]]; then
        cmd+=" $recursive"
    fi

    if [[ -n "$1" ]]; then
        # Remove specific file/directory from trash
        eval "$cmd" "$target/$1"
        echo "Removed '$target/$1'"
    else
        # Remove all files/directories from trash
        eval "$cmd -r" "$target"
        mkdir -p "$target"
        echo "Removed all files/directories from '$target'"
    fi
}
