# Plasma 6 Migration Guide

## Overview

Version 1.1 of the Platform Profile Applet has been updated to be fully compatible with KDE Plasma 6. This document outlines the changes made and what users need to know.

## What Changed?

### API Updates

1. **Qt Imports**
   - Changed from `import QtQuick 2.15` to `import QtQuick` (Qt 6 style)
   - Changed from `import QtQuick.Layouts 1.15` to `import QtQuick.Layouts`

2. **Plasma Module Imports**
   - Changed from `import org.kde.plasma.plasmoid 2.0` to `import org.kde.plasma.plasmoid`
   - Changed from `import org.kde.plasma.core 2.0 as PlasmaCore` to `import org.kde.plasma.core as PlasmaCore`
   - Changed from `import org.kde.plasma.components 3.0 as PlasmaComponents3` to `import org.kde.plasma.components as PlasmaComponents`
   - Changed from `import org.kde.plasma.extras 2.0 as PlasmaExtras` to `import org.kde.plasma.extras as PlasmaExtras`
   - Changed from `import org.kde.kirigami 2.20 as Kirigami` to `import org.kde.kirigami as Kirigami`
   - Added `import org.kde.plasma.plasma5support as Plasma5Support` for DataSource

3. **Root Element**
   - Changed from `Item` to `PlasmoidItem` in main.qml
   - This is the new standard for Plasma 6 applets

4. **Property Bindings**
   - Changed `Plasmoid.compactRepresentation` to `compactRepresentation`
   - Changed `Plasmoid.fullRepresentation` to `fullRepresentation`
   - Changed `plasmoid.expanded` to `root.expanded`
   - Changed `Plasmoid.toolTipMainText` to `toolTipMainText`
   - Changed `Plasmoid.toolTipSubText` to `toolTipSubText`

5. **DataSource**
   - Changed from `PlasmaCore.DataSource` to `Plasma5Support.DataSource`
   - This is the Plasma 6 way to access shell execution

### Metadata Changes

Updated `metadata.json`:

- Added `X-Plasma-API-Minimum-Version: "6.0"` to require Plasma 6
- Removed `X-Plasma-API: "declarativeappletscript"` (deprecated)
- Moved `KPackageStructure` to top of file (better practice)
- Bumped version to 1.1

### Installation Script Changes

Updated `install.sh`:

- Now requires `kpackagetool6`
- Provides clear error message if Plasma 5 detected
- Suggests upgrading to Plasma 6

Updated `uninstall.sh`:

- Now requires `kpackagetool6`
- Simplified logic (Plasma 5 support removed)

## Why Plasma 6 Only?

The Plasma 6 API introduces significant improvements and changes that make it incompatible with Plasma 5. Rather than maintaining complex compatibility code, we've chosen to focus on Plasma 6 for the following reasons:

1. **Modern API**: Plasma 6 uses Qt 6 with better performance and features
2. **Long-term Support**: Plasma 6 is the current and future version
3. **Cleaner Code**: No need for version detection and compatibility layers
4. **Better Maintenance**: Single codebase is easier to maintain and update

## For Plasma 5 Users

If you're still using Plasma 5, you have two options:

1. **Upgrade to Plasma 6** (recommended)
   - Most distributions now offer Plasma 6
   - Better performance and features
   - Long-term support

2. **Use Previous Version**
   - Version 1.0 was compatible with both Plasma 5 and 6
   - However, it won't receive updates
   - Check out the `v1.0` tag if available

## Installation on Plasma 6

```bash
# Clone the repository
git clone https://github.com/Scott-Nx/Platform-Profile_Applet.git
cd Platform-Profile_Applet

# Run installation script (requires Plasma 6)
./install.sh
```

The installer will check for Plasma 6 and refuse to install on Plasma 5.

## Verification

To verify your Plasma version:

```bash
# Check Plasma version
plasmashell --version

# Check if kpackagetool6 is available
which kpackagetool6

# Check Qt version
qmake --version  # or qmake6 --version
```

## Troubleshooting

### "Unsupported Widget" Error

**Symptom**: Widget shows "This Widget was written for an unknown older version of Plasma"

**Cause**: Using version 1.0 (or older) on Plasma 6

**Solution**: Install version 1.1+ which has full Plasma 6 support

### "kpackagetool6 not found"

**Symptom**: Installation script reports kpackagetool6 is missing

**Cause**: Plasma 6 development tools not installed

**Solution**: Install plasma-sdk package for your distribution:

```bash
# Debian/Ubuntu
sudo apt install plasma-sdk

# Fedora
sudo dnf install plasma-sdk

# Arch Linux
sudo pacman -S plasma-sdk
```

### "This applet requires Plasma 6"

**Symptom**: Installation script exits with Plasma 6 requirement message

**Cause**: Running Plasma 5

**Solution**: Either upgrade to Plasma 6 or use version 1.0

## Technical Details

### PlasmoidItem vs Item

Plasma 6 introduces `PlasmoidItem` as the root element for applets. Key differences:

- **Direct Properties**: Properties like `toolTipMainText` are direct properties of PlasmoidItem
- **Representation Properties**: `compactRepresentation` and `fullRepresentation` are direct properties
- **Context Properties**: Some properties like `expanded` are now on the root item, not `plasmoid`

### Plasma5Support Module

The `plasma5support` module provides backward compatibility for features that were in PlasmaCore:

- **DataSource**: Moved from `PlasmaCore.DataSource` to `Plasma5Support.DataSource`
- **Executable Engine**: Still available through Plasma5Support for shell command execution

This ensures migration is smooth while encouraging use of newer APIs where available.

## Future Updates

We will continue to improve the applet with:

- Better integration with Plasma 6 features
- Improved performance using Qt 6 capabilities
- Enhanced UI using new Kirigami components
- Potential D-Bus integration for event-driven updates

## Questions?

If you have questions about the Plasma 6 migration:

1. Check this migration guide
2. Review the updated README.md
3. Check the issue tracker on GitHub
4. Create a new issue if your problem isn't covered

## Version Comparison

| Feature     | v1.0 (Plasma 5) | v1.2 (Plasma 6) |
| ----------- | --------------- | --------------- |
| Plasma 5    | Yes             | No              |
| Plasma 6    | No              | Full            |
| Qt Version  | 5.15+           | 6.x             |
| API Style   | Legacy          | Modern          |
| Maintenance | Ended           | Active          |

---

Updated: 2025-10-30
Version: 1.2
