import QtQuick
import qs.modules.common

StyledText {
    id: root

    property real iconSize: 16
    property real fill: 0

    font.family: Appearance.iconFont
    font.pixelSize: root.iconSize
    font.hintingPreference: Font.PreferNoHinting
    font.variableAxes: ({
        "FILL": root.fill,
        "opsz": root.iconSize
    })
}
