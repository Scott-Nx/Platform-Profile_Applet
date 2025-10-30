#!/bin/bash
# Uninstallation script for Platform Profile Applet (Plasma 6)

set -e

APPLET_NAME="org.kde.plasma.platformprofile"

echo "Uninstalling Platform Profile Applet..."

# Check if kpackagetool6 is available
if command -v kpackagetool6 &> /dev/null; then
    KPACKAGETOOL="kpackagetool6"
else
    echo "Error: kpackagetool6 not found."
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
