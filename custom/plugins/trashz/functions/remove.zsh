function rm2trash() {
    local silent=false

    # Parse options
    while getopts ":m" opt; do
        case $opt in

            m)
                silent=true
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                ;;
        esac
    done
    shift $((OPTIND - 1))

    # Check if ~/.trash directory exists, if not, create it
    if [ ! -d ~/.trash ]; then
        mkdir -p ~/.trash
    fi
    
    # Move each file/directory to ~/.trash
    for item in "$@"; do
        # Get the absolute path of the file/directory to be deleted
        abs_path=$(realpath "$item")

        # Extract the relative path
        rel_path=${abs_path#"$HOME"/}

        # Replace slashes with underscores in the relative path to avoid conflicts
        rel_path_underscore=$(echo "$rel_path" | tr '/' '_')

        # If the first character of rel_path_underscore is '_', remove it
        if [ "${rel_path_underscore:0:1}" = "_" ]; then
            rel_path_underscore="${rel_path_underscore:1}"
        fi

        # Generate a unique filename for the trash
        timestamp=$(date +%s)
        trash_file="$HOME/.trash/$rel_path_underscore.$timestamp"

        # Move the file/directory to ~/.trash
        mv "$abs_path" "$trash_file"

        # Echo message each epoch
        if [ "$silent" = false ]; then
            echo "Moved '$abs_path' to '$trash_file'"
        fi
    done
}
