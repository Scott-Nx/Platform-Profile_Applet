#!/bin/bash
# Demo script to simulate platform profile changes for testing

DEMO_DIR="/tmp/demo-platform-profile"

# Create demo directory
mkdir -p "$DEMO_DIR"

# Create demo files
echo "balanced" > "$DEMO_DIR/platform_profile"
echo "low-power balanced performance" > "$DEMO_DIR/platform_profile_choices"

echo "Demo platform profile files created in $DEMO_DIR"
echo ""
echo "Current profile:"
cat "$DEMO_DIR/platform_profile"
echo ""
echo "Available profiles:"
cat "$DEMO_DIR/platform_profile_choices"
echo ""
echo "To test the applet with these files:"
echo "1. Edit package/contents/ui/main.qml"
echo "2. Change profilePath to: $DEMO_DIR/platform_profile"
echo "3. Change choicesPath to: $DEMO_DIR/platform_profile_choices"
echo "4. Reinstall the applet: ./install.sh"
echo ""
echo "To simulate profile changes:"
echo "  echo 'performance' > $DEMO_DIR/platform_profile"
echo "  echo 'low-power' > $DEMO_DIR/platform_profile"
echo "  echo 'balanced' > $DEMO_DIR/platform_profile"
