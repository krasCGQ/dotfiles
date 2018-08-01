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
ZIPSIGNER=${HOME}/.files/bin/zipsigner-2.1.jar

# Export every variables to satisfy shellcheck
export BTGDIR OPTDIR ZIPSIGNER

# Source my notebook (and common) environment setup
# shellcheck source=/dev/null
. "${HOME}/KudProject/scripts/env/notebook"
