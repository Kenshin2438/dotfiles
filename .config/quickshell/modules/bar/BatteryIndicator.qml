import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.modules.common
import qs.modules.common.widgets

Item {
    id: root

    property real percentage: 0
    property bool charging: false
    readonly property bool low: percentage <= 0.2

    implicitWidth: batteryProgress.implicitWidth
    implicitHeight: Appearance.barHeight

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: batteryProcess.running = true
    }

    Process {
        id: batteryProcess
        command: ["upower", "-i", "/org/freedesktop/UPower/devices/DisplayDevice"]
        stdout: StdioCollector {
            onStreamFinished: {
                const percentage = text.match(/percentage:\s*(\d+)%/);
                const state = text.match(/state:\s*(\S+)/);
                if (percentage)
                    root.percentage = Number(percentage[1]) / 100;
                if (state)
                    root.charging = state[1] === "charging";
            }
        }
    }

    ClippedProgressBar {
        id: batteryProgress
        anchors.centerIn: parent
        value: root.percentage
        highlightColor: root.low && !root.charging ? Appearance.colError : Appearance.colOnSecondaryContainer

        Item {
            anchors.centerIn: parent
            width: batteryProgress.valueBarWidth
            height: batteryProgress.valueBarHeight

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: (parent.height - height) / 2
                spacing: 0

                MaterialSymbol {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: -2
                    Layout.rightMargin: -2
                    visible: root.charging && root.percentage < 1
                    text: "bolt"
                    fill: 1
                    iconSize: 12
                }

                StyledText {
                    Layout.alignment: Qt.AlignVCenter
                    font: batteryProgress.font
                    text: batteryProgress.text
                }
            }
        }
    }
}
