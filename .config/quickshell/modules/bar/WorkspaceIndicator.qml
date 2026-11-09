import QtQuick
import qs.modules.common
import qs.modules.common.widgets

Item {
    id: root

    anchors.fill: parent
    required property int index
    property int buttonWidth: 26
    property int indicatorMargin: 2
    property int indicatorSize: 22
    property alias indicatorRectangle: indicatorRect
    property alias color: indicatorRect.color

    property var indexPair: AnimatedTabIndexPair {
        index: root.index
    }

    Rectangle {
        id: indicatorRect
        anchors.verticalCenter: parent.verticalCenter
        property real position: Math.min(root.indexPair.idx1, root.indexPair.idx2) * root.buttonWidth + root.indicatorMargin
        property real length: Math.abs(root.indexPair.idx1 - root.indexPair.idx2) * root.buttonWidth + root.indicatorSize

        x: position
        implicitWidth: length
        implicitHeight: root.indicatorSize
        radius: height / 2
        color: Appearance.colPrimary
    }
}
