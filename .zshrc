# export ZSH=$HOME/.oh-my-zsh

# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnosterzak"
# ZSH_THEME="powerlevel10k/powerlevel10k"
source $HOME/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme

# plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/plugins/git/git.plugin.zsh
# source $ZSH/oh-my-zsh.sh

# rust
export CARGO_HOME="$HOME/.cargo"
# cuda
export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64:/usr/local/applications/Qt/6.6.0/gcc_64/lib:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda-12.2
# Qt
export QT_PLUGIN_PATH=/usr/local/applications/Qt/6.6.0/gcc_64/plugins:$QT_PLUGIN_PATH
export QML2_IMPORT_PATH=/usr/local/applications/Qt/6.6.0/gcc_64/qml:$QML2_IMPORT_PATH
# go
export GOROOT=$HOME/.go-sdk/go1.22.0
export GOPATH=$HOME/go
# dotnet
export DOTNET_PATH=$HOME/.dotnet
# PATH
export PATH=$CARGO_HOME/bin:$GOROOT/bin:$DOTNET_PATH:$CUDA_HOME/bin:/usr/local/applications/Qt/6.6.0/gcc_64/bin:/usr/local/applications/jetbrains/clion/bin/cmake/linux/x64/bin:$PATH

AppFolder="/usr/local/applications"

# System command
alias rm=rm2trash
alias ls="logo-ls"
alias ll="ls -al"
alias cls="clear"
alias t="tree"
# apt command
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias uninstall="sudo apt-get remove --purge"
alias i="sudo apt-get install"
# jetbrains command
# alias pycharm="$AppFolder/jetbrains/pycharm/bin/pycharm.sh"
# alias clion="$AppFolder/jetbrains/clion/bin/clion.sh"
# alias webstorm="$AppFolder/jetbrains/webstorm/bin/webstorm.sh"
# alias intellij="$AppFolder/jetbrains/intellij/bin/intellij.sh"
# alias goland="$AppFolder/jetbrains/goland/bin/goland.sh"
# core command
alias cpu="sudo dmidecode -t 4 | grep ID"
alias serial="sudo dmidecode -t 2 | grep Serial"
alias mac="sudo lshw -c network | grep serial | head -n 1"
alias core="sudo uname -r"
alias neofetch="fastfetch"
# utils
alias untar="tar -zxvf"
alias untarxz="tar -xvf"
# special for circuit design
# alias logisim="java -jar $AppFolder/logisim/logisim-evolution.jar"

# Welcome message
figlet "Hi, Tropinone!" | lolcat

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

function proxy_on() {
    local server=${1:-"127.0.0.1"}
    local port=${2:-7890}
    export http_proxy=http://$server:$port
    export https_proxy=\$http_proxy
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
