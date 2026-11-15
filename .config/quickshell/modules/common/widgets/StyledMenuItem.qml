pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.modules.common

Item {
    id: root

    required property var entry
    property bool parentMenuVisible: false
    property bool isCurrentItem: false
    readonly property string buttonIcon: {
        if (entry.buttonType === QsMenuButtonType.RadioButton)
            return entry.checkState === Qt.Checked ? "radio_button_checked" : "radio_button_unchecked";
        if (entry.checkState === Qt.Checked)
            return "check_box";
        if (entry.checkState === Qt.PartiallyChecked)
            return "indeterminate_check_box";
        return "check_box_outline_blank";
    }
    signal activated
    signal selectionRequested

    function activate() {
        if (!entry.enabled || entry.isSeparator)
            return;
        if (entry.hasChildren)
            root.selectionRequested();
        else {
            entry.triggered();
            activated();
        }
    }

    implicitHeight: entry.isSeparator ? 9 : 34
    height: implicitHeight
    opacity: entry.enabled ? 1 : 0.45

    Rectangle {
        anchors.fill: parent
        visible: !root.entry.isSeparator
        radius: 7
        color: mouseArea.containsMouse && root.entry.enabled ? Appearance.colSurfaceContainerLowHover : "transparent"

        Behavior on color {
            ColorAnimation {
                duration: Appearance.animationDuration
            }
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        height: 1
        visible: root.entry.isSeparator
        color: Appearance.colSecondaryContainer
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 9
        anchors.rightMargin: 9
        spacing: 8
        visible: !root.entry.isSeparator

        MaterialSymbol {
            visible: root.entry.buttonType !== QsMenuButtonType.None
            text: root.buttonIcon
            iconSize: 15
            color: Appearance.colOnSurface
        }

        IconImage {
            visible: root.entry.icon.length > 0
            source: root.entry.icon
            implicitSize: 16
            asynchronous: true
            mipmap: true
        }

        StyledText {
            Layout.fillWidth: true
            text: root.entry.text
            color: Appearance.colOnSurface
            font.pixelSize: 13
            elide: Text.ElideRight
        }

        MaterialSymbol {
            visible: root.entry.hasChildren
            text: "chevron_right"
            iconSize: 18
            color: Appearance.colOutline
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: !root.entry.isSeparator
        hoverEnabled: true
        cursorShape: root.entry.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        onEntered: root.selectionRequested()
        onClicked: root.activate()
    }

    Loader {
        id: submenu
        active: root.parentMenuVisible && root.entry.hasChildren && root.isCurrentItem
        onActiveChanged: {
            if (active)
                setSource("StyledMenu.qml", {
                        target: root,
                        menu: root.entry,
                        isSubmenu: true,
                        visible: true
                    });
            else
                setSource("");
        }

        Connections {
            target: submenu.item
            function onActivated() {
                root.activated();
            }
        }
    }
}
