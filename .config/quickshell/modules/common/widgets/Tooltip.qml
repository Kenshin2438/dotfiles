pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.modules.common

PopupWindow {
    id: root

    required property MouseArea target
    property string text: ""

    visible: target.containsMouse && text.length > 0
    implicitWidth: tooltipText.implicitWidth + 20
    implicitHeight: tooltipText.implicitHeight + 12
    color: "transparent"

    anchor {
        item: root.target
        edges: Edges.Bottom
        gravity: Edges.Bottom
        adjustment: PopupAdjustment.Slide
    }

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: Appearance.colSurfaceContainerLow

        StyledText {
            id: tooltipText
            anchors.centerIn: parent
            text: root.text
            color: Appearance.colOnSurface
            font.pixelSize: 12
        }
    }
}
