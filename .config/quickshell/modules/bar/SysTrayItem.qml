pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.modules.common.widgets

MouseArea {
    id: root

    required property SystemTrayItem item
    implicitWidth: 20
    implicitHeight: 20
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
    cursorShape: Qt.PointingHandCursor

    onClicked: event => {
        if (event.button === Qt.LeftButton)
            item.activate();
        else if (event.button === Qt.MiddleButton)
            item.secondaryActivate();
        else if (event.button === Qt.RightButton && item.hasMenu) {
            if (menu.visible)
                menu.close();
            else
                menu.open();
        }
        event.accepted = true;
    }

    IconImage {
        anchors.centerIn: parent
        source: root.item.icon
        implicitSize: 16
        asynchronous: true
        mipmap: true
    }

    StyledMenu {
        id: menu
        target: root
        menu: root.item.menu
    }
}
