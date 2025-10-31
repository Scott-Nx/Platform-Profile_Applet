import QtQuick
import QtQuick.Layouts
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

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.expanded = !root.expanded
        }
        onEntered: {
            root.readCurrentProfile()
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
