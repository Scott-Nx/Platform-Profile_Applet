import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support

PlasmoidItem {
    id: root

    // Property to hold current platform profile
    property string currentProfile: ""
    property var availableProfiles: []
    property bool hasError: false
    property string errorMessage: ""

    // Paths to system files
    readonly property string profilePath: "/sys/firmware/acpi/platform_profile"
    readonly property string choicesPath: "/sys/firmware/acpi/platform_profile_choices"

    compactRepresentation: CompactRepresentation {}
    fullRepresentation: FullRepresentation {}

    // Refresh profile when UI is expanded
    onExpandedChanged: {
        if (expanded) {
            readCurrentProfile()
        }
    }

    // DataSource to execute shell commands
    Plasma5Support.DataSource {
        id: executeSource
        engine: "executable"
        connectedSources: []

        onNewData: {
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            var exitCode = data["exit code"]

            if (sourceName.indexOf("cat " + profilePath) !== -1 && sourceName.indexOf(choicesPath) === -1) {
                if (exitCode === 0 && stdout) {
                    var profile = stdout.trim()
                    // Validate profile name contains only safe characters
                    if (profile.match(/^[a-zA-Z0-9\-]+$/)) {
                        root.currentProfile = profile
                        root.hasError = false
                    } else {
                        console.error("Invalid profile name format:", profile)
                        root.hasError = true
                        root.errorMessage = "Invalid profile name format"
                    }
                } else {
                    root.hasError = true
                    root.errorMessage = "Cannot read platform profile"
                }
            } else if (sourceName.indexOf("cat " + choicesPath) !== -1) {
                if (exitCode === 0 && stdout) {
                    // Parse and validate profile names
                    var profiles = stdout.trim().split(/\s+/)
                    var validProfiles = []

                    // Only accept alphanumeric characters and hyphens
                    for (var i = 0; i < profiles.length; i++) {
                        var profile = profiles[i]
                        if (profile.match(/^[a-zA-Z0-9\-]+$/)) {
                            validProfiles.push(profile)
                        } else {
                            console.warn("Ignoring invalid profile name:", profile)
                        }
                    }

                    root.availableProfiles = validProfiles
                    root.hasError = false
                } else {
                    root.hasError = true
                    root.errorMessage = "Cannot read profile choices"
                }
            }

            disconnectSource(sourceName)
        }

        function exec(cmd) {
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
        // Validate profile name against available profiles to prevent injection
        if (availableProfiles.indexOf(profile) === -1) {
            console.error("Invalid profile name:", profile)
            return
        }

        // Using pkexec to get root privileges
        // Profile is validated against availableProfiles, preventing injection
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

    // Timer for periodic updates (only when UI is expanded)
    Timer {
        id: updateTimer
        interval: 5000
        running: root.expanded
        repeat: true
        onTriggered: {
            readCurrentProfile()
        }
    }

    // Initialize on startup
    Component.onCompleted: {
        readCurrentProfile()
        // Delay reading available profiles to avoid race condition with DataSource
        Qt.callLater(readAvailableProfiles)
    }

    // Tooltip text for Plasma 6
    toolTipMainText: "Platform Profile"
    toolTipSubText: currentProfile ? "Current: " + currentProfile : "Loading..."
}
