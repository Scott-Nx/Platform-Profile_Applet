# Example Platform Profile Files

This directory contains example content for testing the applet without actual hardware support.

## Testing Without Hardware Support

If your system doesn't have `/sys/firmware/acpi/platform_profile*` files, you can test the applet by creating mock files:

### Create Test Directory

```bash
# Create a test directory
mkdir -p /tmp/test-platform-profile

# Create mock platform_profile file
echo "balanced" > /tmp/test-platform-profile/platform_profile

# Create mock platform_profile_choices file
echo "low-power balanced performance" > /tmp/test-platform-profile/platform_profile_choices

# Make them readable
chmod 644 /tmp/test-platform-profile/*
```

### Modify Applet for Testing

To test with these mock files, you can temporarily modify the paths in `package/contents/ui/main.qml`:

```qml
// Change these lines (around line 19-20):
readonly property string profilePath: "/sys/firmware/acpi/platform_profile"
readonly property string choicesPath: "/sys/firmware/acpi/platform_profile_choices"

// To:
readonly property string profilePath: "/tmp/test-platform-profile/platform_profile"
readonly property string choicesPath: "/tmp/test-platform-profile/platform_profile_choices"
```

### Test Profile Changes

```bash
# Change to different profiles
echo "performance" > /tmp/test-platform-profile/platform_profile
echo "low-power" > /tmp/test-platform-profile/platform_profile
echo "balanced" > /tmp/test-platform-profile/platform_profile
```

## Real Hardware Examples

### Lenovo ThinkPad

```bash
$ cat /sys/firmware/acpi/platform_profile
balanced

$ cat /sys/firmware/acpi/platform_profile_choices
low-power balanced performance
```

### Lenovo IdeaPad

```bash
$ cat /sys/firmware/acpi/platform_profile
balanced

$ cat /sys/firmware/acpi/platform_profile_choices
quiet balanced performance
```

## Common Profile Names

Different manufacturers may use different profile names:

- **Performance**: Maximum performance mode
- **Balanced**: Balance between performance and efficiency  
- **Low-power**: Power saving mode
- **Quiet**: Silent/quiet operation mode
- **Cool**: Cooling priority mode

The applet is designed to work with any profile name returned by the system.
