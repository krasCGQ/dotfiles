#!/usr/bin/env bash
ALERT="$CLAM_VIRUSEVENT_VIRUSNAME found in $CLAM_VIRUSEVENT_FILENAME"

# Send an alert to all graphical users.
for ADDRESS in /run/user/*; do
    USERID=${ADDRESS#/run/user/}
    /usr/bin/sudo -u "#$USERID" DBUS_SESSION_BUS_ADDRESS="unix:path=$ADDRESS/bus" PATH=/usr/bin \
        /usr/bin/notify-send -u critical -a "ClamAV On-Access Scanner" -i dialog-warning \
            -w "Malware detected" "$ALERT"
done
