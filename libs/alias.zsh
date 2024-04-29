# System command
alias rm=rm2trash
alias ls="logo-ls"
alias ll="ls -alh"
alias cls="clear"
alias t="tree"
alias fd="fdfind"
# apt command
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias uninstall="sudo apt-get remove --purge"
alias i="sudo apt-get install"
# core command
alias cpu="sudo dmidecode -t 4 | grep ID"
alias serial="sudo dmidecode -t 2 | grep Serial"
alias mac="sudo lshw -c network | grep serial | head -n 1"
alias core="sudo uname -r"
alias neofetch="fastfetch"
# utils
alias untar="tar -zxvf"
alias untarxz="tar -xvf"

function proxy_on() {
    local server=${1:-"127.0.0.1"}
    local port=${2:-7890}
    export http_proxy=http://$server:$port
    export https_proxy=https://$server:$port
    echo -e "终端代理已开启。"
}

function proxy_off() {
    unset http_proxy https_proxy
    echo -e "终端代理已关闭。"
}

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

    if [ -n "$1" ]; then
        # Remove specific file/directory from trash
        /bin/rm "$force" "$recursive" "$target/$1"
        echo "Removed '$target/$1'"
    else
        # Remove all files/directories from trash
        /bin/rm "$force" "$recursive" $target
        mkdir -p $target
        echo "Removed all files/directories from '$target'"
    fi
}

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
