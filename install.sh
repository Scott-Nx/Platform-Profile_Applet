#!/bin/bash
# Installation script for Platform Profile Applet

set -e

APPLET_NAME="org.kde.plasma.platformprofile"
PACKAGE_DIR="package"

echo "Installing Platform Profile Applet..."

# Check if kpackagetool5 or kpackagetool6 is available
if command -v kpackagetool6 &> /dev/null; then
    KPACKAGETOOL="kpackagetool6"
    echo "Using kpackagetool6 (Plasma 6)"
elif command -v kpackagetool5 &> /dev/null; then
    KPACKAGETOOL="kpackagetool5"
    echo "Using kpackagetool5 (Plasma 5)"
else
    echo "Error: kpackagetool5 or kpackagetool6 not found."
    echo "Please install KDE development tools:"
    echo "  - Debian/Ubuntu: sudo apt install plasma-sdk"
    echo "  - Fedora: sudo dnf install plasma-sdk"
    echo "  - Arch: sudo pacman -S plasma-sdk"
    exit 1
fi

# Check if platform profile is supported
if [ ! -f /sys/firmware/acpi/platform_profile ]; then
    echo "Warning: /sys/firmware/acpi/platform_profile not found."
    echo "This system may not support ACPI platform profiles."
    echo "The applet will still be installed but may not function correctly."
fi

# Remove old version if exists
if $KPACKAGETOOL -t Plasma/Applet -s $APPLET_NAME &> /dev/null; then
    echo "Removing old version..."
    $KPACKAGETOOL -t Plasma/Applet -r $APPLET_NAME
fi

# Install the applet
echo "Installing applet..."
$KPACKAGETOOL -t Plasma/Applet -i $PACKAGE_DIR

echo ""
echo "Installation complete!"
echo ""
echo "To add the applet to your panel:"
echo "  1. Right-click on your panel"
echo "  2. Select 'Add Widgets...'"
echo "  3. Search for 'Platform Profile'"
echo "  4. Drag it to your panel"
echo ""
echo "Note: Changing the profile requires root privileges."
echo "Make sure pkexec is installed for authentication."
