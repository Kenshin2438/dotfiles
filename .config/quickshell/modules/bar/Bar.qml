pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules.common

Scope {
    id: root

    property bool open: true

    Variants {
        model: Quickshell.screens

        LazyLoader {
            required property ShellScreen modelData
            active: root.open

            component: PanelWindow {
                screen: modelData
                anchors.top: true
                anchors.left: true
                anchors.right: true
                implicitHeight: Appearance.barHeight
                exclusiveZone: Appearance.barHeight
                exclusionMode: ExclusionMode.Ignore
                color: "transparent"
                WlrLayershell.namespace: "quickshell:bar"
                WlrLayershell.layer: WlrLayer.Top

                BarContent {
                    anchors.fill: parent
                    screen: modelData
                }
            }
        }
    }

    IpcHandler {
        target: "bar"

        function toggle(): void {
            root.open = !root.open;
        }
        function open(): void {
            root.open = true;
        }
        function close(): void {
            root.open = false;
        }
    }
}
