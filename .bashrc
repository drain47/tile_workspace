#!/bin/bash

PS1="\e[1;0m[\e[1;33m${HOSTNAME%%.*}\e[1;0m]-[\e[1;33m\u\e[1;0m]-[\e[1;36m\$\e[1;0m]-[\e[1;33m\w\e[1;0m]\e[1;0m: "

alias wi-fi='sudo systemctl start NetworkManager & nmcli device wifi connect i203 password 98765432'
alias ping='ping google.com'
alias x='startx'
