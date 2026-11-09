import QtQuick
import QtQuick.Layouts
import qs.modules.common

Item {
    id: root

    property real padding: 4
    default property alias items: layout.children
    implicitWidth: layout.implicitWidth + padding * 2
    implicitHeight: Appearance.barHeight

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 3
        anchors.bottomMargin: 3
        color: Appearance.colLayer1
        radius: Appearance.smallRounding
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: root.padding
        anchors.rightMargin: root.padding
        spacing: 3
    }
}
