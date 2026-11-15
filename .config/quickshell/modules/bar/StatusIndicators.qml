import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.services

MouseArea {
    id: root

    readonly property string volumeIcon: Audio.muted ? "volume_off" : Audio.volume === 0 ? "volume_mute" : Audio.volume < 0.33 ? "volume_down" : "volume_up"

    implicitWidth: layout.implicitWidth + 16
    implicitHeight: 30
    hoverEnabled: true
    acceptedButtons: Qt.NoButton
    onWheel: event => Audio.changeVolume(event.angleDelta.y > 0 ? 0.02 : -0.02)

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: root.containsMouse ? Appearance.colSurfaceContainerLowHover : "transparent"
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
            text: root.volumeIcon
            iconSize: 18
            color: Appearance.colOnSurface
        }
        StyledText {
            text: `${Math.round(Audio.volume * 100)}%`
            color: Appearance.colOnSurface
            font.pixelSize: 11
        }
        MaterialSymbol {
            visible: Audio.micMuted
            text: "mic_off"
            iconSize: 18
            color: Appearance.colOnSurface
        }
        MaterialSymbol {
            text: Network.materialSymbol
            iconSize: 18
            color: Appearance.colOnSurface
        }
        MaterialSymbol {
            visible: BluetoothStatus.available
            text: BluetoothStatus.connected ? "bluetooth_connected" : BluetoothStatus.enabled ? "bluetooth" : "bluetooth_disabled"
            iconSize: 18
            color: Appearance.colOnSurface
        }
    }
}
