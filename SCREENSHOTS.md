# Platform Profile Applet - Screenshots & UI Guide

This document describes the user interface of the Platform Profile Applet.

### Icon States

- **Performance Mode**: Speedometer icon
- **Balanced Mode**: Checkmark icon
- **Low-Power Mode**: Battery save icon
- **Quiet Mode**: Battery save icon
- **Loading**: Spinning busy indicator
- **Unknown**: Generic power icon

The icon is interactive - hovering shows a highlight effect, and clicking opens the full popup.

## Popup Interface (Full Representation)

When you click the panel icon, a popup appears with:

### Header Section

- **Icon**: Power management icon
- **Title**: "Platform Profile" (bold, large text)

### Current Profile Display

- **Label**: "Current Profile:"
- **Profile Name**: Large heading showing the active profile
- **Color Coding**:
  - Performance: Red/negative color (high power usage)
  - Balanced: Green/positive color (optimal)
  - Low-Power/Quiet: Neutral color (power saving)

### Profile Selection

- **Section Title**: "Available Profiles:"
- **Profile Buttons**: One button for each available profile
  - Each button shows:
    - Profile name (capitalized)
    - Appropriate icon
    - Checkmark (✓) if currently active
  - Active profile is highlighted
  - Click any button to switch to that profile

### Footer

- **Tip**: "Use Fn+Q to change profiles on Lenovo devices"
  - Small, semi-transparent text
  - Provides helpful context for Lenovo laptop users

## Error States

### Cannot Read Platform Profile

Shows a placeholder with:

- Error icon
- Message: "Error accessing platform profile"
- Explanation with troubleshooting steps:
  - Check for compatible device
  - Verify ACPI support
  - Confirm file existence in /sys/firmware/acpi/

### No Profiles Available

Shows a placeholder with:

- Information icon
- Message: "Loading platform profiles..."
- Appears during initial load

## User Interaction Flow

1. **View Current Profile**:
   - Glance at panel icon badge
   - Or read tooltip on hover

2. **Change Profile**:
   - Click panel icon → popup opens
   - Click desired profile button
   - Enter password in pkexec dialog
   - Profile changes and UI updates

3. **Monitor Changes**:
   - Use Fn+Q shortcut (on supported hardware)
   - Applet automatically detects change within 5 seconds
   - Panel icon and popup update to reflect new profile

## Accessibility Features

- Clear visual indicators for current state
- Color coding for quick recognition
- Keyboard accessible (can be activated via keyboard navigation)
- Tooltip provides information without opening popup
- Large, easy-to-click buttons in popup
- Clear error messages with actionable steps

## Dimensions

- **Panel Icon**: Adapts to panel size (typically 16x16 to 32x32 pixels)
- **Popup**: Minimum 15 grid units wide × 14 grid units tall
- **Popup**: Maximum 20 grid units wide × 20 grid units tall
- **Grid Unit**: Typically 18 pixels (adjusts with Plasma theme)

## Theme Integration

The applet fully respects the Plasma theme:

- Uses theme colors for all UI elements
- Adapts to light/dark themes automatically
- Uses system font settings
- Respects icon theme
- Follows Plasma spacing and sizing guidelines
