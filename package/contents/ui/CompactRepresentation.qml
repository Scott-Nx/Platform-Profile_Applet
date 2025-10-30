import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.kirigami 2.20 as Kirigami

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
            plasmoid.expanded = !plasmoid.expanded
        }

        // Icon display
        Kirigami.Icon {
            id: icon
            anchors.fill: parent
            source: getProfileIcon()
            active: mouseArea.containsMouse

            // Badge with abbreviated profile name
            Rectangle {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                width: Kirigami.Units.iconSizes.small * 0.6
                height: width
                radius: width / 2
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.textColor
                border.width: 1
                visible: root.currentProfile !== ""

                PlasmaComponents3.Label {
                    anchors.centerIn: parent
                    text: getProfileShortText()
                    font.pixelSize: parent.height * 0.6
                    font.bold: true
                }
            }
        }

        // Loading indicator
        PlasmaComponents3.BusyIndicator {
            anchors.centerIn: parent
            running: root.currentProfile === ""
            visible: running
        }
    }
}
