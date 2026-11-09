import QtQuick
import Quickshell
import qs.modules.common
import qs.services

Item {
    required property var workspaceRoot
    required property int index
    readonly property int workspaceId: workspaceRoot.workspaceId(index)
    readonly property var biggestWindow: workspaceRoot.biggestWindow[index]
    readonly property string iconName: AppIcons.guessIcon(biggestWindow?.class)
    readonly property bool hasIcon: biggestWindow && iconName !== "image-missing"
    readonly property string iconPath: hasIcon ? Quickshell.iconPath(iconName) : ""

    implicitWidth: workspaceRoot.workspaceButtonWidth
    implicitHeight: Appearance.barHeight
}
