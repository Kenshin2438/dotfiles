import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.modules.common
import qs.modules.common.widgets
import qs.services

Item {
    id: root

    required property var screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    readonly property bool focusingThisMonitor: HyprlandData.activeWorkspace?.monitor === monitor?.name
    readonly property var biggestWindow: HyprlandData.biggestWindowForWorkspace(monitor?.activeWorkspace?.id ?? 1)
    readonly property var displayedWindow: focusingThisMonitor && activeWindow?.activated && biggestWindow ? activeWindow : biggestWindow
    implicitWidth: layout.implicitWidth

    ColumnLayout {
        id: layout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: -4

        StyledText {
            Layout.fillWidth: true
            text: root.displayedWindow?.class ?? root.displayedWindow?.appId ?? "Desktop"
            color: Appearance.colSubtext
            font.pixelSize: 11
            elide: Text.ElideRight
        }
        StyledText {
            Layout.fillWidth: true
            text: root.displayedWindow?.title ?? `Workspace ${root.monitor?.activeWorkspace?.id ?? 1}`
            font.pixelSize: 13
            elide: Text.ElideRight
        }
    }
}
