# Firejail profile for floorp
# This file is overwritten after every install/update
# Persistent local customizations
include floorp.local
# Persistent global definitions
include globals.local

# Note that this profile is based on waterfox.profile, while allowed DBus interactions are copied
# directly from the official Flatpak package one.ablaze.floorp except for portal interactions.

noblacklist ${HOME}/.cache/floorp
noblacklist ${HOME}/.floorp

mkdir ${HOME}/.cache/floorp
mkdir ${HOME}/.floorp
whitelist ${HOME}/.cache/floorp
whitelist ${HOME}/.floorp
#whitelist /usr/share/floorp

# Add the next lines to your floorp.local if you want to use the migration wizard.
#noblacklist ${HOME}/.mozilla
#whitelist ${HOME}/.mozilla

private-bin dbus-launch,dbus-send,env,floorp,which
private-etc floorp

dbus-user filter
dbus-user.own org.mozilla.floorp.*
dbus-user.own org.mpris.MediaPlayer2.firefox.*
dbus-user.talk org.a11y.Bus
dbus-user.talk org.freedesktop.FileManager1
dbus-user.talk org.freedesktop.Notifications
dbus-user.talk org.freedesktop.ScreenSaver
dbus-user.talk org.freedesktop.portal.Desktop
dbus-user.talk org.gnome.SessionManager
dbus-user.talk org.gtk.vfs.*
ignore dbus-user none

dbus-system filter
dbus-system.talk org.freedesktop.NetworkManager
ignore dbus-system none

# Redirect
include firefox-common.profile
