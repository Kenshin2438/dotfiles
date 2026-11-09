import QtQuick
import qs.modules.common
import qs.modules.common.widgets

WorkspaceItem {
    id: root

    readonly property bool showingNumbers: !hasIcon
    readonly property color contentColor: workspaceRoot.occupied[index] && workspaceId !== workspaceRoot.fakeWorkspace ? Appearance.colOnSecondaryContainer : Appearance.colOnLayer1Inactive

    FadeLoader {
        anchors.centerIn: parent
        shown: !root.showingNumbers
        sourceComponent: Circle {
            anchors.centerIn: parent
            diameter: 4
            color: root.contentColor
        }
    }

    FadeLoader {
        anchors.centerIn: parent
        shown: root.showingNumbers
        sourceComponent: StyledText {
            anchors.centerIn: parent
            text: root.workspaceId
            color: root.contentColor
            font.pixelSize: root.workspaceId === 10 ? 11 : 12
        }
    }
}
