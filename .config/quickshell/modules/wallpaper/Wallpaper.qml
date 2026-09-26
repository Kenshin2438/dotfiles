pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
    id: root

    property string wallpaperPath: ""

    FileView {
        path: `${Quickshell.env("XDG_STATE_HOME")}/quickshell/user/generated/wallpaper.txt`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.wallpaperPath = text().trim()
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            WlrLayershell.layer: WlrLayer.Background
            exclusionMode: ExclusionMode.Ignore

            Image {
                anchors.fill: parent
                source: root.wallpaperPath !== "" ? `file://${root.wallpaperPath}` : ""
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                cache: false
            }
        }
    }
}
