#!/hint/zsh
# shellcheck shell=bash
#
# SPDX-License-Identifier: Unlicense
#

#
# How Sheldon config file for Zsh is initialized:
# $ sheldon init --shell zsh
# $ sheldon add autosuggestions --github zsh-users/zsh-autosuggestions
# $ sheldon add fsyh --github zdharma-continuum/fast-syntax-highlighting
# $ sheldon add keybindings --github NickKaramoff/ohmyzsh-key-bindings
#
# Initialization for this part is done through common ~/.shrc sourcing
#

# Which shell are we running?
# Save it early before sourcing any additional scripts as $0 may change
CURRENT_SHELL=$(command echo -n "$(basename "$0" 2>/dev/null)" | sed 's/^-//')
CURRENT_SHELL=${CURRENT_SHELL:-$(basename "$SHELL")}

# Pre-create XDG-compatible data directories
mkdir -m 700 -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" "${XDG_STATE_HOME:-$HOME/.local/state}/zsh"

# Tell Zsh where to save history of commands
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/zsh/history

# Control how many last lines of history to keep.
# Debian defaults to 2000 in their ~/.bashrc
SAVEHIST=2000

# Initialize shell completion system and load it
zstyle :compinstall filename "${ZDOTDIR:-$HOME}"/.zshrc
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompcache
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompdump

# Load internal mechanics of color handling
autoload -Uz colors && colors

## Enable a set of shell options.
## Check which ones are enabled/disabled with setopt/unsetopt respectively
# autocd: Automatically change directory if target is a folder
# histignoredups: Bash-equivalent of HISTCONTROL=ignoredups
# histignorespace: Bash-equivalent of HISTCONTROL=ignorespace
setopt autocd histignoredups histignorespace

# Zsh recommends Emacs editing configuration for key bindings.
# Even when we need to override it later, it's a good idea to keep this line
bindkey -e

# Exporting these serve no real purpose other than satisfying shellcheck
export HISTFILE SAVEHIST

# Include shared shell configuration
# shellcheck source=SCRIPTDIR/../../.shrc-common
source "$HOME"/.files/.shrc-common

# Unset CURRENT_SHELL as we don't need it anymore
unset CURRENT_SHELL
