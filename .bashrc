#!/bin/bash


#[[ $- != *i* ]] && return

#[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\W][\u]\$ '
#PS1="[\e[1;35m\w\e[1;0m]\e[1;32m\$\e[1;0m >> "

alias wi-fi='sudo systemctl start NetworkManager & nmcli device wifi connect i203 password 98765432'
alias ping='ping google.com'
alias x='startx'
alias gitpac='makepkg -si --skippgpcheck'

#case ${TERM} in
#  Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*)
#    PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
#
#    ;;
#  screen*)
#    PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
#    ;;
#esac

#[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
