import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

Item {
    id: compactRoot

    Layout.preferredWidth: Kirigami.Units.iconSizes.medium
    Layout.preferredHeight: Kirigami.Units.iconSizes.medium

    // Get the icon for the current profile
    function getProfileIcon() {
        if (root.currentProfile === "performance") {
            return "speedometer"
        } else if (root.currentProfile === "balanced") {
            return "dialog-ok"
        } else if (root.currentProfile === "low-power" || root.currentProfile === "quiet") {
            return "battery-profile-powersave"
        } else {
            return "preferences-system-power-management"
        }
    }

    // Get abbreviated text for profile
    function getProfileShortText() {
        if (root.currentProfile === "performance") {
            return "P"
        } else if (root.currentProfile === "balanced") {
            return "B"
        } else if (root.currentProfile === "low-power") {
            return "LP"
        } else if (root.currentProfile === "quiet") {
            return "Q"
        } else {
            return "?"
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.expanded = !root.expanded
        }

        // Icon display
        Kirigami.Icon {
            id: icon
            anchors.fill: parent
            source: getProfileIcon()
            active: mouseArea.containsMouse
        }

        // Loading indicator
        PlasmaComponents.BusyIndicator {
            anchors.centerIn: parent
            running: root.currentProfile === ""
            visible: running
        }
    }
}
