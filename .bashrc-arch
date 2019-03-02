#!/usr/bin/env bash
# ~/.bashrc

## BASH DEFAULTS ##

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

## CUSTOM MODIFICATIONS ##

# For use with my environment setup only
BTGDIR=${HOME}/KudProject/gcc
OPTDIR=/opt/kud
SWAP_FILE=${HOME}/.swapfile
ZIPSIGNER=${HOME}/.files/bin/zipsigner-3.0.jar

# Export every variables to satisfy shellcheck
export BTGDIR OPTDIR SWAP_FILE ZIPSIGNER

# Source my notebook (and common) environment setup
# shellcheck source=/dev/null
. "${HOME}"/KudProject/scripts/env/notebook

# Additionally, source some snippets
for SNIPPET in pia tg_sendinline; do
    # shellcheck source=/dev/null
    . "${HOME}"/KudProject/scripts/snippets/${SNIPPET}
done
