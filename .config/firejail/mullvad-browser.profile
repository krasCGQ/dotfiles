# Firejail profile for mullvad-browser
# Description: Privacy-focused web browser developed by Mullvad VPN and the Tor Project
# Persistent local customizations
include mullvad-browser.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.cache/mullvad/mullvad-browser
noblacklist ${HOME}/.mullvad/mullvad-browser

mkdir ${HOME}/.cache/mullvad/mullvad-browser
mkdir ${HOME}/.mullvad/mullvad-browser
whitelist ${HOME}/.cache/mullvad/mullvad-browser
whitelist ${HOME}/.mullvad/mullvad-browser

private-opt mullvad-browser

# Redirect
include firefox-common.profile
