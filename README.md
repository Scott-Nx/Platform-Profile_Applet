# Platform Profile Applet

A KDE Plasma Widget (Applet) for viewing and changing ACPI platform profiles on Linux systems, particularly useful for Lenovo laptops with Fn+Q functionality.

![Platform Profile Applet](https://img.shields.io/badge/KDE-Plasma-blue)
![License](https://img.shields.io/badge/License-GPL--3.0-green)

## Overview

This Plasma applet provides an easy way to:
- **View** the current platform profile at a glance
- **Switch** between available platform profiles with a single click
- **Monitor** profile changes made via Fn+Q keyboard shortcut (on supported devices)

### What are Platform Profiles?

Platform profiles control the performance and power behavior of your system through ACPI (Advanced Configuration and Power Interface). Common profiles include:

- **Performance**: Maximum performance, higher power consumption
- **Balanced**: Balance between performance and power efficiency
- **Low-Power/Quiet**: Power saving mode with reduced performance

## Features

- **Quick Access**: Panel icon shows current profile at a glance
- **Easy Switching**: Click to open popup and select desired profile
- **Visual Feedback**: Color-coded profiles and icons
- **Fn+Q Compatible**: Automatically detects profile changes from keyboard shortcuts
- **Secure**: Uses pkexec for authenticated profile changes
- **Real-time Updates**: Monitors profile changes every 5 seconds

## Requirements

### System Requirements
- Linux system with ACPI platform profile support
- `/sys/firmware/acpi/platform_profile` file must exist
- `/sys/firmware/acpi/platform_profile_choices` file must exist

### Software Requirements
- KDE Plasma 6.x (primary support)
- Qt 6.x
- `pkexec` (for changing profiles with root privileges)
- `kpackagetool6` (for installation)

**Note**: This version is designed for Plasma 6. For Plasma 5 support, please use an older release.

### Check System Compatibility

To check if your system supports platform profiles:

```bash
# Check if platform profile files exist
ls -l /sys/firmware/acpi/platform_profile*

# View current profile
cat /sys/firmware/acpi/platform_profile

# View available profiles
cat /sys/firmware/acpi/platform_profile_choices
```

## Installation

### Automatic Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/Scott-Nx/Platform-Profile_Applet.git
   cd Platform-Profile_Applet
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Add the widget to your panel:
   - Right-click on your KDE panel
   - Select "Add Widgets..."
   - Search for "Platform Profile"
   - Drag it to your panel or desktop

### Manual Installation

If you prefer to install manually:

```bash
# For Plasma 6
kpackagetool6 -t Plasma/Applet -i package

# For Plasma 5
kpackagetool5 -t Plasma/Applet -i package
```

### Updating

To update the applet:

```bash
git pull
./install.sh
```

The installation script will automatically remove the old version before installing the new one.

## Uninstallation

Run the uninstallation script:

```bash
./uninstall.sh
```

Or manually:

```bash
# For Plasma 6
kpackagetool6 -t Plasma/Applet -r org.kde.plasma.platformprofile

# For Plasma 5
kpackagetool5 -t Plasma/Applet -r org.kde.plasma.platformprofile
```

## Usage

### Panel Icon

The panel icon displays:
- An icon representing the current profile
- A badge with abbreviated profile name:
  - **P**: Performance
  - **B**: Balanced
  - **LP**: Low-Power
  - **Q**: Quiet

### Popup Interface

Click the panel icon to open the popup interface, which shows:
- Current profile name (color-coded)
- Buttons for all available profiles
- Active profile marked with a checkmark (✓)

### Changing Profiles

1. Click the panel icon to open the popup
2. Click on the desired profile button
3. Authenticate with your password when prompted (pkexec)
4. The profile will change and the interface updates automatically

## Troubleshooting

### Applet shows "Error accessing platform profile"

**Cause**: The system doesn't support ACPI platform profiles or files are not accessible.

**Solutions**:
- Verify files exist: `ls -l /sys/firmware/acpi/platform_profile*`
- Check your hardware supports this feature (common on Lenovo laptops)
- Ensure ACPI is enabled in BIOS/UEFI

### Cannot change profile / Authentication fails

**Cause**: Missing or misconfigured pkexec.

**Solutions**:
- Install PolicyKit:
  - Debian/Ubuntu: `sudo apt install policykit-1`
  - Fedora: `sudo dnf install polkit`
  - Arch: `sudo pacman -S polkit`

### Applet doesn't appear in widget list

**Cause**: Installation failed or Plasma needs restart.

**Solutions**:
- Restart Plasma: `plasmashell --replace &`
- Or log out and log back in
- Verify installation: `kpackagetool5 -t Plasma/Applet -s org.kde.plasma.platformprofile`

### Profile changes not reflected

**Cause**: Delayed update or permission issues.

**Solutions**:
- Wait a few seconds (updates every 5 seconds)
- Check manually: `cat /sys/firmware/acpi/platform_profile`
- Verify file permissions on platform_profile files

## Development

### Project Structure

```
Platform-Profile_Applet/
├── package/
│   ├── metadata.json              # Applet metadata
│   └── contents/
│       └── ui/
│           ├── main.qml           # Main applet logic
│           ├── CompactRepresentation.qml  # Panel icon
│           └── FullRepresentation.qml     # Popup interface
├── install.sh                     # Installation script
├── uninstall.sh                   # Uninstallation script
├── LICENSE                        # GPL-3.0 License
└── README.md                      # This file
```

### Testing

To test the applet without installing:

```bash
# For Plasma 6
plasmoidviewer -a package

# For Plasma 5
plasmoidviewer -a package
```

### Debugging

Enable debug output:

```bash
# View Plasma logs
journalctl -f | grep plasma
```

## Supported Devices

This applet works on any Linux system that supports ACPI platform profiles. It's particularly useful for:

- **Lenovo ThinkPad** laptops with Fn+Q
- **Lenovo ThinkBook** laptops with Fn+Q
- **Lenovo IdeaPad** laptops
- Other laptops with ACPI platform profile support

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- KDE Plasma team for the excellent widget framework
- Lenovo for implementing ACPI platform profile support
- Linux kernel developers for ACPI subsystem
