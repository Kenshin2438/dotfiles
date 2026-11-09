import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.services

Item {
    id: root

    required property var screen
    readonly property int compact: screen.width <= 1000 ? 2 : screen.width <= 1300 ? 1 : 0
    readonly property int resourceModuleWidth: compact === 2 ? 140 : compact === 1 ? 155 : 175
    readonly property int statusModuleWidth: compact === 2 ? 155 : compact === 1 ? 180 : 205

    Rectangle {
        anchors.fill: parent
        color: Appearance.colLayer0
    }

    MouseArea {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: middle.left
        onWheel: Quickshell.execDetached(["brightnessctl", "-e4", "-n2", "set", event.angleDelta.y > 0 ? "5%+" : "5%-"])

        ActiveWindow {
            anchors.fill: parent
            anchors.margins: 10
            screen: root.screen
        }
    }

    Row {
        id: middle
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 2

        BarGroup {
            anchors.verticalCenter: parent.verticalCenter
            implicitWidth: root.resourceModuleWidth
            Resources {
                Layout.fillWidth: true
            }
        }

        BarGroup {
            anchors.verticalCenter: parent.verticalCenter
            padding: 2
            Workspaces {
                screen: root.screen
                Layout.fillHeight: true
            }
        }

        BarGroup {
            anchors.verticalCenter: parent.verticalCenter
            implicitWidth: root.statusModuleWidth
            ClockWidget {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                showDate: root.compact < 2
            }
            BatteryIndicator {
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }

    MouseArea {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: middle.right
        anchors.right: parent.right
        acceptedButtons: Qt.NoButton
        onWheel: Audio.changeVolume(event.angleDelta.y > 0 ? 0.02 : -0.02)

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 6
            anchors.rightMargin: 6
            spacing: 6
            layoutDirection: Qt.RightToLeft

            StatusIndicators {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }
            SysTray {
                visible: root.compact === 0
                Layout.fillHeight: true
            }
            Item {
                Layout.fillWidth: true
            }
        }
    }
}
