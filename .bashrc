#!/bin/bash

PS1="\n\e[1;0m[\e[1;33m${HOSTNAME%%.*}\e[1;0m]-[\e[1;33m\u\e[1;0m]-[\e[1;36m\$\e[1;0m]-[\e[1;33m\w\e[1;0m]\n\e[1;0m>> \e[0;0m"

alias wpa1='sudo wpa_supplicant -B -i wlan0 -c ~/.config/wpa/wpa-i203.conf && sudo dhclient wlan0'
alias wpa2='sudo wpa_supplicant -B -i wlan0 -c ~/.config/wpa/wpa-Keenetic-2990.conf && sudo dhclient wlan0'
alias ping='ping google.com'
alias x='startx'
