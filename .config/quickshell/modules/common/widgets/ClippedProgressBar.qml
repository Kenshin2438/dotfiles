import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import qs.modules.common

ProgressBar {
    id: root

    property real valueBarWidth: 30
    property real valueBarHeight: 18
    property color highlightColor: Appearance.colOnSecondaryContainer
    property color trackColor: Appearance.transparentize(highlightColor, 0.5)
    property string text: Math.round(value * 100)
    default property Item textMask: Item {
        width: root.valueBarWidth
        height: root.valueBarHeight

        StyledText {
            anchors.centerIn: parent
            font: root.font
            text: root.text
        }
    }

    font.pixelSize: 13
    font.weight: text.length > 2 ? Font.Medium : Font.DemiBold

    background: Item {
        implicitWidth: root.valueBarWidth
        implicitHeight: root.valueBarHeight
    }

    contentItem: Rectangle {
        id: contentItem
        anchors.fill: parent
        radius: 9999
        color: root.trackColor
        visible: false

        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width * root.visualPosition
            radius: 2
            color: root.highlightColor
        }
    }

    OpacityMask {
        id: roundingMask
        visible: false
        anchors.fill: parent
        source: contentItem
        maskSource: Rectangle {
            width: contentItem.width
            height: contentItem.height
            radius: contentItem.radius
        }
    }

    OpacityMask {
        anchors.fill: parent
        source: roundingMask
        invert: true
        maskSource: root.textMask
    }
}
