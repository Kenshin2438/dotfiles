pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var palette: ({})

    readonly property color colLayer0: palette.surface ?? "#141313"
    readonly property color colLayer1: palette.surface_container_low ?? "#1c1b1c"
    readonly property color colOnLayer0: palette.on_background ?? "#e6e1e1"
    readonly property color colOnLayer1: palette.on_surface_variant ?? "#cbc5ca"
    readonly property color colSubtext: palette.outline ?? "#948f94"
    readonly property color colPrimary: palette.primary ?? "#cbc4cb"
    readonly property color colOnPrimary: palette.on_primary ?? "#322f34"
    readonly property color colSecondaryContainer: palette.secondary_container ?? "#4d4b4d"
    readonly property color colOnSecondaryContainer: palette.on_secondary_container ?? "#ece6e9"
    readonly property color colError: palette.error ?? "#ffb4ab"
    readonly property color colLayer1Hover: mix(colLayer1, colOnLayer1, 0.9)
    readonly property color colOnLayer1Inactive: mix(colLayer1, colOnLayer1, 0.45)

    readonly property int barHeight: 36
    readonly property int smallRounding: 10
    readonly property string mainFont: "LXGW WenKai"
    readonly property string iconFont: "Material Symbols Rounded"
    readonly property int animationDuration: 200

    function mix(color1, color2, amount) {
        const c1 = Qt.color(color1);
        const c2 = Qt.color(color2);
        return Qt.rgba(amount * c1.r + (1 - amount) * c2.r,
            amount * c1.g + (1 - amount) * c2.g,
            amount * c1.b + (1 - amount) * c2.b,
            amount * c1.a + (1 - amount) * c2.a);
    }

    function transparentize(color, amount) {
        const c = Qt.color(color);
        return Qt.rgba(c.r, c.g, c.b, c.a * (1 - amount));
    }

    FileView {
        path: `${Quickshell.env("XDG_STATE_HOME")}/quickshell/user/generated/colors.json`
        watchChanges: true
        onLoaded: root.palette = JSON.parse(text())
        onFileChanged: reload()
    }
}
