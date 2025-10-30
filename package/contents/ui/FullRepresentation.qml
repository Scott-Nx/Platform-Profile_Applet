import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.extras as PlasmaExtras
import org.kde.kirigami as Kirigami

ColumnLayout {
    id: fullRoot
    
    Layout.minimumWidth: Kirigami.Units.gridUnit * 15
    Layout.minimumHeight: Kirigami.Units.gridUnit * 12
    Layout.maximumWidth: Kirigami.Units.gridUnit * 20
    Layout.maximumHeight: Kirigami.Units.gridUnit * 20

    spacing: Kirigami.Units.smallSpacing

    // Header
    PlasmaExtras.PlasmoidHeading {
        Layout.fillWidth: true

        RowLayout {
            anchors.fill: parent
            
            Kirigami.Icon {
                Layout.preferredWidth: Kirigami.Units.iconSizes.medium
                Layout.preferredHeight: Kirigami.Units.iconSizes.medium
                source: "preferences-system-power-management"
            }

            PlasmaComponents.Label {
                Layout.fillWidth: true
                text: "Platform Profile"
                font.weight: Font.Bold
                font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.2
            }
        }
    }

    // Content area
    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: Kirigami.Units.largeSpacing

        // Current profile display
        PlasmaComponents.Label {
            Layout.fillWidth: true
            text: "Current Profile:"
            font.weight: Font.Bold
        }

        PlasmaExtras.Heading {
            Layout.fillWidth: true
            level: 2
            text: root.currentProfile || "Loading..."
            color: {
                if (root.currentProfile === "performance") return Kirigami.Theme.negativeTextColor
                if (root.currentProfile === "balanced") return Kirigami.Theme.positiveTextColor
                if (root.currentProfile === "low-power" || root.currentProfile === "quiet") return Kirigami.Theme.neutralTextColor
                return Kirigami.Theme.textColor
            }
        }

        // Separator
        Kirigami.Separator {
            Layout.fillWidth: true
        }

        // Available profiles list
        PlasmaComponents.Label {
            Layout.fillWidth: true
            text: "Available Profiles:"
            font.weight: Font.Bold
            visible: root.availableProfiles.length > 0
        }

        // Profile buttons
        Repeater {
            model: root.availableProfiles
            
            PlasmaComponents.Button {
                Layout.fillWidth: true
                
                property string profileName: modelData
                
                text: {
                    var name = profileName
                    if (profileName === root.currentProfile) {
                        name += " ✓"
                    }
                    return name.charAt(0).toUpperCase() + name.slice(1)
                }
                
                icon.name: {
                    if (profileName === "performance") return "speedometer"
                    if (profileName === "balanced") return "dialog-ok"
                    if (profileName === "low-power" || profileName === "quiet") return "battery-profile-powersave"
                    return "system-run"
                }
                
                highlighted: profileName === root.currentProfile
                
                onClicked: {
                    root.setProfile(profileName)
                }
            }
        }

        // Error message display
        PlasmaExtras.PlaceholderMessage {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: root.hasError
            
            iconName: "error"
            text: root.errorMessage || "Error accessing platform profile"
            explanation: "Make sure:\n• You have a compatible device\n• ACPI platform profile is supported\n• The files exist in /sys/firmware/acpi/"
        }

        // Info message if no profiles available
        PlasmaExtras.PlaceholderMessage {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: !root.hasError && root.availableProfiles.length === 0 && root.currentProfile === ""
            
            iconName: "dialog-information"
            text: "Loading platform profiles..."
        }

        Item {
            Layout.fillHeight: true
        }
    }

    // Footer with help text
    PlasmaComponents.Label {
        Layout.fillWidth: true
        text: "Tip: Use Fn+Q to toggle profiles on Lenovo devices"
        font.pointSize: Kirigami.Theme.smallFont.pointSize
        opacity: 0.6
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }
}
