# UI Mockup Description

## Popup Interface Layout

```
╔═══════════════════════════════════════════╗
║  ⚙️  Platform Profile               [×]   ║
╠═══════════════════════════════════════════╣
║                                           ║
║  Current Profile:                         ║
║  Performance                              ║
║  (displayed in red/large text)            ║
║                                           ║
║  ─────────────────────────────────────    ║
║                                           ║
║  Available Profiles:                      ║
║                                           ║
║  ┌─────────────────────────────────────┐  ║
║  │ ⚡ Performance ✓                     │  ║
║  └─────────────────────────────────────┘  ║
║                                           ║
║  ┌─────────────────────────────────────┐  ║
║  │ ✓ Balanced                          │  ║
║  └─────────────────────────────────────┘  ║
║                                           ║
║  ┌─────────────────────────────────────┐  ║
║  │ 🔋 Low-Power                        │  ║
║  └─────────────────────────────────────┘  ║
║                                           ║
║  ─────────────────────────────────────    ║
║                                           ║
║  Use Fn+Q to toggle profiles              ║
║       on Lenovo devices                   ║
║                                           ║
╚═══════════════════════════════════════════╝
```

## Error State Display

```
╔═══════════════════════════════════════════╗
║  ⚙️  Platform Profile               [×]    ║
╠═══════════════════════════════════════════╣
║                                           ║
║           ⚠️                              ║
║                                           ║
║    Error accessing platform profile       ║
║                                           ║
║    Make sure:                             ║
║    • You have a compatible device         ║
║    • ACPI platform profile is supported   ║
║    • The files exist in                   ║
║      /sys/firmware/acpi/                  ║
║                                           ║
╚═══════════════════════════════════════════╝
```

## Interaction Flow

1. **View Current State**

   ```
   Panel → [⚙️●P] ← Hover shows tooltip: "Platform Profile: Performance"
   ```

2. **Open Popup**

   ```
   Click → Popup appears with current profile highlighted
   ```

3. **Change Profile**

   ```
   Click "Balanced" → pkexec dialog appears
   Enter password → Profile changes
   Icon updates: [⚙️●P] → [⚙️●B]
   ```

4. **External Change (Fn+Q)**
   ```
   Press Fn+Q → System changes profile
   Within 5 seconds → Applet detects change
   Icon updates automatically: [⚙️●B] → [⚙️●P]
   ```

## Accessibility

- [x] Large clickable areas (48dp minimum)
- [x] Clear text labels
- [x] Keyboard navigation support
- [x] Screen reader compatible
- [x] High contrast mode support
- [x] Tooltip provides context
- [x] Visual feedback on hover/click

## Theme Integration

The applet adapts to:

- Light/dark theme (Breeze, Breeze Dark)
- Custom color schemes
- Icon themes
- Font sizes (respects system settings)
- Panel sizes (auto-scales)
