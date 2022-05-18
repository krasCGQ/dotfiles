# shellcheck shell=bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Init Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

alias dir='exa --color=auto'
alias ls='exa --color=auto'
alias vdir='exa -H -g -l --color=auto'

alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'
alias grep='grep --color=auto'

# Source my environment setup
[[ $(</etc/hostname) == grozny ]] && TYPE=server || TYPE=notebook
# shellcheck source=/dev/null
. "${HOME}"/.files/scripts/env/$TYPE

# Additionally, source some snippets
for SNIPPET in tg_sendinline zipsigner; do
    # shellcheck source=/dev/null
    . "${HOME}"/.files/scripts/snippets/${SNIPPET}
done
