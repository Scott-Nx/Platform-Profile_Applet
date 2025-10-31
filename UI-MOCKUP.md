# UI Mockup Description

## Panel Icon Appearance

```
┌───────────────────┐
│  ┌─────┐          │
│  │ ⚙️  │          │  ← Power management icon
│  │   ●P│          │  ← Badge with "P" (Performance)
│  └─────┘          │
└───────────────────┘

States:
- Performance: Speedometer icon + "P" badge (red tint)
- Balanced: Checkmark icon + "B" badge (green tint)
- Low-Power: Battery icon + "LP" badge (blue tint)
- Quiet: Battery icon + "Q" badge (blue tint)
```

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
║  ┌─────────────────────────────────────┐ ║
║  │ ⚡ Performance ✓                     │ ║ ← Active (highlighted)
║  └─────────────────────────────────────┘ ║
║                                           ║
║  ┌─────────────────────────────────────┐ ║
║  │ ✓ Balanced                           │ ║
║  └─────────────────────────────────────┘ ║
║                                           ║
║  ┌─────────────────────────────────────┐ ║
║  │ 🔋 Low-Power                         │ ║
║  └─────────────────────────────────────┘ ║
║                                           ║
║  ─────────────────────────────────────    ║
║                                           ║
║  Tip: Use Fn+Q to toggle profiles         ║
║       on Lenovo devices                   ║
║                                           ║
╚═══════════════════════════════════════════╝
```

## Error State Display

```
╔═══════════════════════════════════════════╗
║  ⚙️  Platform Profile               [×]   ║
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

## Color Coding

- **Performance**: Red/orange tint (⚠️ high power)
- **Balanced**: Green tint (✓ optimal)
- **Low-Power**: Blue/cyan tint (🔋 saving)
- **Quiet**: Blue/cyan tint (🔇 silent)

## Accessibility

- ✅ Large clickable areas (48dp minimum)
- ✅ Clear text labels
- ✅ Keyboard navigation support
- ✅ Screen reader compatible
- ✅ High contrast mode support
- ✅ Tooltip provides context
- ✅ Visual feedback on hover/click

## Theme Integration

The applet adapts to:
- Light/dark theme (Breeze, Breeze Dark)
- Custom color schemes
- Icon themes
- Font sizes (respects system settings)
- Panel sizes (auto-scales)

## Responsive Behavior

**Vertical Panel:**
```
┌───┐
│ ⚙️│
│ ●P│
└───┘
```

**Horizontal Panel:**
```
┌───────┐
│ ⚙️ ●P │
└───────┘
```

**Desktop Placement:**
```
┌─────────┐
│  ⚙️      │
│ ●P       │
│          │
│Platform  │
│Profile   │
└─────────┘
```
