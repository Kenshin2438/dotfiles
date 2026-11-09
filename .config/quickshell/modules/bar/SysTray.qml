import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.modules.common
import qs.modules.common.widgets

Item {
    implicitWidth: layout.implicitWidth
    implicitHeight: Appearance.barHeight

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            model: SystemTray.items.values
            delegate: SysTrayItem {
                required property SystemTrayItem modelData
                item: modelData
                Layout.alignment: Qt.AlignVCenter
            }
        }

        StyledText {
            visible: SystemTray.items.values.length > 0
            text: "•"
            color: Appearance.colSubtext
            font.pixelSize: 16
        }
    }
}
