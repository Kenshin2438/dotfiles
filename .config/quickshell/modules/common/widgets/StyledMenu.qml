pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.modules.common

PopupWindow {
    id: root

    required property Item target
    required property var menu
    property bool isSubmenu: false
    signal activated

    function open() {
        list.currentIndex = -1;
        visible = true;
    }

    function close() {
        visible = false;
    }

    visible: false
    grabFocus: true
    implicitWidth: 240
    implicitHeight: Math.min(400, list.contentHeight + 12)
    color: "transparent"

    anchor {
        item: root.target
        edges: root.isSubmenu ? Edges.Right : Edges.Bottom
        gravity: root.isSubmenu ? Edges.Right : Edges.Bottom
        adjustment: PopupAdjustment.Slide | PopupAdjustment.Flip
        margins.right: root.isSubmenu ? 4 : 0
        margins.bottom: root.isSubmenu ? 0 : 4
    }

    QsMenuOpener {
        id: opener
        menu: root.menu
    }

    Rectangle {
        anchors.fill: parent
        radius: Appearance.smallRounding
        color: Appearance.colSurfaceContainerLow
        border.width: 1
        border.color: Appearance.colSecondaryContainer
        opacity: root.visible ? 1 : 0
        scale: root.visible ? 1 : 0.98
        transformOrigin: root.isSubmenu ? Item.Left : Item.Top

        Behavior on opacity {
            NumberAnimation {
                duration: 120
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 120
            }
        }
    }

    ListView {
        id: list
        anchors.fill: parent
        anchors.margins: 6
        clip: true
        model: opener.children
        spacing: 2
        currentIndex: -1
        keyNavigationWraps: true
        focus: root.visible
        boundsBehavior: Flickable.StopAtBounds

        delegate: StyledMenuItem {
            required property int index
            required property var modelData
            entry: modelData
            width: ListView.view.width
            parentMenuVisible: root.visible
            isCurrentItem: list.currentIndex === index
            onSelectionRequested: list.currentIndex = index
            onActivated: {
                root.close();
                root.activated();
            }
        }

        Keys.onEscapePressed: root.close()
        Keys.onReturnPressed: {
            if (currentItem)
                currentItem.activate();
        }
        Keys.onRightPressed: {
            if (currentItem?.entry.hasChildren)
                currentItem.activate();
        }
    }
}
