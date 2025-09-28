# Firejail profile for AyuGram
# Description: ToS breaking Telegram client
# This file is overwritten after every install/update
# Persistent local customizations
#include AyuGram.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.local/share/AyuGramDesktop
mkdir ${HOME}/.local/share/AyuGramDesktop
whitelist ${HOME}/.local/share/AyuGramDesktop

private-bin AyuGram

dbus-user.own com.ayugram.desktop.*

# Redirect
include telegram.profile
