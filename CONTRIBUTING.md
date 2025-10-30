# Contributing to Platform Profile Applet

Thank you for your interest in contributing to the Platform Profile Applet! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue on GitHub with:

1. **Clear title**: Describe the bug briefly
2. **System information**:
   - Linux distribution and version
   - KDE Plasma version (`plasmashell --version`)
   - Qt version
   - Kernel version (`uname -r`)
3. **Steps to reproduce**: Detailed steps to reproduce the issue
4. **Expected behavior**: What should happen
5. **Actual behavior**: What actually happens
6. **Logs**: Relevant logs from `journalctl -f | grep plasma`
7. **Platform profile info**: Output of:
   ```bash
   cat /sys/firmware/acpi/platform_profile
   cat /sys/firmware/acpi/platform_profile_choices
   ```

### Suggesting Features

Feature requests are welcome! Please create an issue with:

1. **Clear description** of the feature
2. **Use case**: Why is this feature needed?
3. **Proposed solution**: How should it work?
4. **Alternatives**: Other ways to achieve the same goal

### Pull Requests

1. **Fork** the repository
2. **Create a branch** for your feature or fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**:
   - Follow the existing code style
   - Add comments for complex logic
   - Test thoroughly on your system
4. **Commit** with clear messages:
   ```bash
   git commit -m "Add feature: description"
   ```
5. **Push** to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
6. **Create a Pull Request** on GitHub

### Code Style Guidelines

#### QML Files
- Use 4 spaces for indentation
- Use camelCase for property and function names
- Use PascalCase for component filenames
- Add comments for non-obvious functionality
- Keep lines under 120 characters when possible

#### Shell Scripts
- Use bash for scripts
- Add error handling (`set -e`)
- Add comments for each major section
- Use meaningful variable names

## Development Setup

### Prerequisites

Install KDE development tools:

```bash
# Debian/Ubuntu
sudo apt install plasma-sdk qtdeclarative5-dev

# Fedora
sudo dnf install plasma-sdk qt5-qtdeclarative-devel

# Arch Linux
sudo pacman -S plasma-sdk qt5-declarative
```

### Testing Your Changes

1. **Test with plasmoidviewer**:
   ```bash
   plasmoidviewer -a package
   ```

2. **Install and test in real Plasma**:
   ```bash
   ./install.sh
   # Add to panel and test
   ```

3. **Check for errors**:
   ```bash
   journalctl -f | grep plasma
   ```

### Areas for Contribution

We welcome contributions in these areas:

1. **Translations**: Add support for more languages
2. **Icons**: Improve or add custom icons for profiles
3. **Configuration**: Add configuration options (e.g., update interval)
4. **Profile Detection**: Better detection of profile types
5. **Error Handling**: Improve error messages and handling
6. **Documentation**: Improve README, add tutorials
7. **Testing**: Add automated tests
8. **Performance**: Optimize polling and updates

## Questions?

If you have questions about contributing, feel free to:
- Open an issue with the "question" label
- Start a discussion on GitHub Discussions (if enabled)

## Code of Conduct

Be respectful and constructive in all interactions. We aim to create a welcoming environment for all contributors.

Thank you for contributing! 🎉
