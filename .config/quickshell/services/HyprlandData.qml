pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
    id: root

    property var windowList: []
    property var activeWorkspace: null
    property var monitors: []

    function biggestWindowForWorkspace(workspaceId) {
        return windowList.filter(window => window.workspace.id === workspaceId).reduce((largest, window) => {
            const largestArea = (largest?.size?.[0] ?? 0) * (largest?.size?.[1] ?? 0);
            const windowArea = (window.size?.[0] ?? 0) * (window.size?.[1] ?? 0);
            return windowArea > largestArea ? window : largest;
        }, null);
    }

    function refresh() {
        refreshTimer.restart();
    }

    Timer {
        id: refreshTimer
        interval: 50
        onTriggered: {
            clients.running = true;
            activeWorkspace.running = true;
            monitors.running = true;
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (!["openlayer", "closelayer", "screencast"].includes(event.name))
                root.refresh();
        }
    }

    Component.onCompleted: root.refresh()

    Process {
        id: clients
        command: ["hyprctl", "-j", "clients"]
        stdout: StdioCollector {
            onStreamFinished: root.windowList = JSON.parse(text)
        }
    }

    Process {
        id: activeWorkspace
        command: ["hyprctl", "-j", "activeworkspace"]
        stdout: StdioCollector {
            onStreamFinished: root.activeWorkspace = JSON.parse(text)
        }
    }

    Process {
        id: monitors
        command: ["hyprctl", "-j", "monitors"]
        stdout: StdioCollector {
            onStreamFinished: root.monitors = JSON.parse(text)
        }
    }
}
