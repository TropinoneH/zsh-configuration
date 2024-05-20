# System command
alias ls="logo-ls"
alias ll="ls -alh"
alias cls="clear"
alias t="tree"
alias fd="fdfind"
alias sudo="sudo "
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
