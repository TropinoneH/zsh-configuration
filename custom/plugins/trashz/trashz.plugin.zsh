fpath=("${0:A:h}" "${fpath[@]}")

for file in ${0:A:h}/functions/*.zsh; do
    source $file
done


function trashz() {
    # Decide which function to call based on the first argument
    case "$1" in
        clean)
            # Call the clean_trash function
            clean_trash "${@:2}"  # Pass remaining arguments
            ;;
        restore)
            # Call the restore_trash function
            restore_trash "${@:2}"  # Pass remaining arguments
            ;;
        rm)
            # Call the rm2trash function
            rm2trash "${@:2}"  # Pass remaining arguments
            ;;
        *)
            echo "Usage: trashz {clean|restore|rm} [options]"
            return 1
            ;;
    esac
}

alias rm="trashz rm"
