import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.common.widgets

Item {
    id: root

    property bool showDate: true
    implicitWidth: layout.implicitWidth
    implicitHeight: Appearance.barHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 3

        StyledText {
            text: Qt.locale().toString(clock.date, "hh:mm")
            color: Appearance.colOnLayer1
            font.pixelSize: 16
        }
        StyledText {
            visible: root.showDate
            text: "•"
            color: Appearance.colOnLayer1
            font.pixelSize: 13
        }
        StyledText {
            visible: root.showDate
            text: Qt.locale().toString(clock.date, "ddd, MM/dd")
            color: Appearance.colOnLayer1
            font.pixelSize: 13
        }
    }
}
