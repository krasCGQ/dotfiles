#!/usr/bin/env bash
# ^ explicit declaration

#
# ~/.bash_profile
#

# shellcheck source=/dev/null
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Auto start tbsm after login on first two VTs
[[ ${XDG_VTNR} -le 2 && -z ${TMUX} ]] && tbsm
