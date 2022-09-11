#!/hint/bash
#
# SPDX-License-Identifier: Unlicense
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Which shell are we running?
# Save it early before sourcing any additional scripts as $0 may change
# shellcheck disable=SC2034
CURRENT_SHELL=${0/-/}

# Control how many last lines of history to keep.
# Debian defaults to 2000 in their ~/.bashrc
HISTFILESIZE=2000

# Control how Bash should handle history.
# ignoreboth will ignore all proceeding repetitions (ignoredups) as well as
# commands that start with spaces (ignorespace) (this is Debian's default)
HISTCONTROL=ignoreboth

## Enable a set of shell options.
## Some are Debian defaults
# autocd: Automatically change directory if target is a folder
# histappend: Append to instead of overwriting history file
# globstar: Using ** will match all files and directories and their children
shopt -s autocd histappend globstar

# Exporting these serve no real purpose other than satisfying shellcheck
export HISTCONTROL HISTFILESIZE

# Include shared shell configuration
# shellcheck source=SCRIPTDIR/.shrc-common
source "$HOME"/.files/.shrc-common

# Unset CURRENT_SHELL as we don't need it anymore
unset CURRENT_SHELL
