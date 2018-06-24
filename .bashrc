# ~/.bashrc

## BASH DEFAULTS ##

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

## CUSTOM MODIFICATIONS ##

# GNU nano as default editor
export EDITOR=nano

# For use with my environment setup only
ZIPSIGNER=${HOME}/.files/bin/zipsigner-2.1.jar

# Source my notebook (and common) environment setup
source ${HOME}/KudProject/scripts/env_notebook.comp
