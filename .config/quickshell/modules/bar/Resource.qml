import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets

MouseArea {
    id: root

    required property string iconName
    required property real percentage
    property int warningThreshold: 100
    property string tooltipText: ""
    implicitWidth: layout.implicitWidth
    implicitHeight: Appearance.barHeight
    hoverEnabled: true

    Tooltip {
        target: root
        text: root.tooltipText
    }

    RowLayout {
        id: layout
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2

        CircularProgress {
            value: root.percentage
            colPrimary: root.percentage * 100 >= root.warningThreshold ? Appearance.colError : Appearance.colOnSecondaryContainer
            MaterialSymbol {
                anchors.centerIn: parent
                text: root.iconName
                fill: 1
                iconSize: 14
                color: Appearance.colOnSecondaryContainer
            }
        }

        StyledText {
            text: Math.round(root.percentage * 100)
            color: Appearance.colOnSurfaceVariant
            font.pixelSize: 12
        }
    }
}
