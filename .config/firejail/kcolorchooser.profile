# Firejail profile for kcolorchooser
# Description: Color selector and palette editor
# Persistent local customizations
include default.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.config/Kvantum
noblacklist ${HOME}/.config/QtProject.conf
noblacklist ${HOME}/.config/kcolorchooserrc
noblacklist ${HOME}/.config/kdeglobals

include disable-common.inc
include disable-devel.inc
include disable-exec.inc
include disable-interpreters.inc
include disable-proc.inc
include disable-programs.inc
include disable-shell.inc
include disable-xdg.inc

mkfile ${HOME}/.config/kcolorchooserrc
whitelist ${HOME}/.config/QtProject.conf
whitelist ${HOME}/.config/kcolorchooserrc
read-only ${HOME}/.config/Kvantum
read-only ${HOME}/.config/kdeglobals

# Workaround bug 1793
blacklist ${HOME}/.config/*
whitelist ${HOME}/.config

apparmor
caps.drop all
net none
no3d
nodvd
nogroups
noinput
nonewprivs
noprinters
#noroot
nosound
notv
nou2f
novideo
protocol unix
seccomp

disable-mnt
private-bin kcolorchooser
private-cache
private-dev
private-etc none
#private-lib
private-opt none
private-tmp

dbus-user filter
# Screen color picker on Wayland
dbus-user.talk org.freedesktop.portal.*
# Allowed by the Flatpak version, might be necessary
dbus-user.talk com.canonical.AppMenu.Registrar
dbus-user.talk org.kde.kconfig.notify
dbus-user.talk org.kde.KGlobalSettings
dbus-system none

memory-deny-write-execute
restrict-namespaces
