pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
    id: root

    property list<string> layoutCodes: []
    property string currentLayoutName: ""
    property string currentLayoutCode: ""

    function updateLayoutCode() {
        const lines = layoutFile.text().split("\n");
        for (const line of lines) {
            const match = line.match(/^\s*(\S+)\s+(?:(\S+)\s+)?(.+)$/);
            if (match?.[3] !== currentLayoutName)
                continue;
            root.currentLayoutCode = match[2] ? match[2] + match[1] : match[1];
            return;
        }
        root.currentLayoutCode = currentLayoutName;
    }

    onCurrentLayoutNameChanged: updateLayoutCode()

    FileView {
        id: layoutFile
        path: "/usr/share/X11/xkb/rules/base.lst"
        onLoaded: root.updateLayoutCode()
    }

    Process {
        id: devices
        running: true
        command: ["hyprctl", "-j", "devices"]
        stdout: StdioCollector {
            onStreamFinished: {
                const parsed = JSON.parse(text);
                const keyboard = parsed.keyboards?.find(item => item.main);
                if (!keyboard)
                    return;
                root.layoutCodes = keyboard.layout.split(",");
                root.currentLayoutName = keyboard.active_keymap;
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "configreloaded")
                devices.running = true;
            if (event.name !== "activelayout")
                return;
            if (root.layoutCodes.length > 1)
                root.currentLayoutName = event.data.substring(event.data.indexOf(",") + 1);
        }
    }
}
