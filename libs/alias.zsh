# System command
alias ls="exa --icons=always"
alias ll="ls -alH"
alias cls="clear"
alias t="tree"
alias sudo="sudo "
# apt command
alias update="sudo pacman -Syy"
alias upgrade="sudo pacman -Syyu"
alias uninstall="sudo pacman -Rs"
alias i="sudo pacman -S"
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
