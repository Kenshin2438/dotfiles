import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.services

MouseArea {
    id: root

    implicitWidth: layout.implicitWidth + 16
    implicitHeight: 30
    hoverEnabled: true
    acceptedButtons: Qt.NoButton
    onWheel: Audio.changeVolume(event.angleDelta.y > 0 ? 0.02 : -0.02)

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: root.containsMouse ? Appearance.colLayer1Hover : "transparent"
        Behavior on color {
            ColorAnimation {
                duration: Appearance.animationDuration
            }
        }
    }

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 11

        MaterialSymbol {
            visible: Audio.muted
            text: "volume_off"
            iconSize: 18
            color: Appearance.colOnLayer0
        }
        MaterialSymbol {
            visible: Audio.micMuted
            text: "mic_off"
            iconSize: 18
            color: Appearance.colOnLayer0
        }
        StyledText {
            visible: HyprlandXkb.layoutCodes.length > 1
            text: HyprlandXkb.currentLayoutCode.split(":").map(layout => layout.split("-")[0].slice(0, 4)).join("\n")
            horizontalAlignment: Text.AlignHCenter
            color: Appearance.colOnLayer0
            font.pixelSize: 11
        }
        MaterialSymbol {
            text: Network.materialSymbol
            iconSize: 18
            color: Appearance.colOnLayer0
        }
        MaterialSymbol {
            visible: BluetoothStatus.available
            text: BluetoothStatus.connected ? "bluetooth_connected" : BluetoothStatus.enabled ? "bluetooth" : "bluetooth_disabled"
            iconSize: 18
            color: Appearance.colOnLayer0
        }
    }
}
