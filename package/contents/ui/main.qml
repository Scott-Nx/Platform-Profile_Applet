import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kirigami 2.20 as Kirigami

Item {
    id: root

    // Property to hold current platform profile
    property string currentProfile: ""
    property var availableProfiles: []
    property bool hasError: false
    property string errorMessage: ""
    
    // Paths to system files
    readonly property string profilePath: "/sys/firmware/acpi/platform_profile"
    readonly property string choicesPath: "/sys/firmware/acpi/platform_profile_choices"

    Plasmoid.compactRepresentation: CompactRepresentation {}
    Plasmoid.fullRepresentation: FullRepresentation {}

    // DataSource to execute shell commands
    PlasmaCore.DataSource {
        id: executeSource
        engine: "executable"
        connectedSources: []
        
        onNewData: {
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            var exitCode = data["exit code"]
            
            console.log("Command output:", sourceName, "stdout:", stdout, "stderr:", stderr, "exitCode:", exitCode)
            
            if (sourceName.indexOf("cat " + profilePath) !== -1) {
                if (exitCode === 0 && stdout) {
                    root.currentProfile = stdout.trim()
                    root.hasError = false
                } else {
                    root.hasError = true
                    root.errorMessage = "Cannot read platform profile"
                }
            } else if (sourceName.indexOf("cat " + choicesPath) !== -1) {
                if (exitCode === 0 && stdout) {
                    root.availableProfiles = stdout.trim().split(/\s+/)
                    root.hasError = false
                } else {
                    root.hasError = true
                    root.errorMessage = "Cannot read profile choices"
                }
            }
            
            disconnectSource(sourceName)
        }
        
        function exec(cmd) {
            console.log("Executing:", cmd)
            connectSource(cmd)
        }
    }

    // Function to read current profile
    function readCurrentProfile() {
        executeSource.exec("cat " + profilePath)
    }

    // Function to read available profiles
    function readAvailableProfiles() {
        executeSource.exec("cat " + choicesPath)
    }

    // Function to set profile (requires root privileges)
    function setProfile(profile) {
        console.log("Attempting to set profile to:", profile)
        // Using pkexec to get root privileges
        executeSource.exec("pkexec sh -c 'echo " + profile + " > " + profilePath + "'")
        // Re-read after a short delay to confirm change
        reloadTimer.restart()
    }

    // Timer to reload profile after change
    Timer {
        id: reloadTimer
        interval: 500
        onTriggered: {
            readCurrentProfile()
        }
    }

    // Timer for periodic updates
    Timer {
        id: updateTimer
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            readCurrentProfile()
        }
    }

    // Initialize on startup
    Component.onCompleted: {
        readCurrentProfile()
        readAvailableProfiles()
    }

    // Tooltip text
    Plasmoid.toolTipMainText: "Platform Profile"
    Plasmoid.toolTipSubText: currentProfile ? "Current: " + currentProfile : "Loading..."
}
