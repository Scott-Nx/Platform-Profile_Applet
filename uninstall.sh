#!/bin/bash
# Uninstallation script for Platform Profile Applet

set -e

APPLET_NAME="org.kde.plasma.platformprofile"

echo "Uninstalling Platform Profile Applet..."

# Check if kpackagetool5 or kpackagetool6 is available
if command -v kpackagetool6 &> /dev/null; then
    KPACKAGETOOL="kpackagetool6"
elif command -v kpackagetool5 &> /dev/null; then
    KPACKAGETOOL="kpackagetool5"
else
    echo "Error: kpackagetool5 or kpackagetool6 not found."
    exit 1
fi

# Remove the applet
if $KPACKAGETOOL -t Plasma/Applet -s $APPLET_NAME &> /dev/null; then
    echo "Removing applet..."
    $KPACKAGETOOL -t Plasma/Applet -r $APPLET_NAME
    echo "Uninstallation complete!"
else
    echo "Applet not found or already uninstalled."
fi
