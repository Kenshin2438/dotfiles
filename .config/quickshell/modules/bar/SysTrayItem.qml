pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

MouseArea {
    id: root

    required property SystemTrayItem item
    implicitWidth: 20
    implicitHeight: 20
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
    cursorShape: Qt.PointingHandCursor

    onPressed: event => {
        if (event.button === Qt.LeftButton)
            item.activate();
        else if (event.button === Qt.MiddleButton)
            item.secondaryActivate();
        else if (event.button === Qt.RightButton && item.hasMenu)
            menu.open();
        event.accepted = true;
    }

    IconImage {
        anchors.centerIn: parent
        source: root.item.icon
        implicitSize: 16
        asynchronous: true
        mipmap: true
    }

    QsMenuAnchor {
        id: menu
        menu: root.item.menu
        anchor {
            item: root
            gravity: Edges.Bottom
            edges: Edges.Bottom
            adjustment: PopupAdjustment.ResizeY | PopupAdjustment.SlideX
        }
    }
}
