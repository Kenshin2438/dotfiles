import QtQuick
import QtQuick.Shapes
import qs.modules.common

Item {
    id: root

    property int implicitSize: 18
    property int lineWidth: 2
    property real value: 0
    property color colPrimary: Appearance.colOnSecondaryContainer
    property color colSecondary: Appearance.colSecondaryContainer
    readonly property real clampedValue: Math.min(1, Math.max(0, value))
    readonly property real radius: implicitSize / 2 - lineWidth

    implicitWidth: implicitSize
    implicitHeight: implicitSize

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: root.colSecondary
            strokeWidth: root.lineWidth
            capStyle: ShapePath.RoundCap
            fillColor: "transparent"

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.radius
                radiusY: root.radius
                startAngle: -110
                sweepAngle: -Math.max(0, 320 - root.clampedValue * 360)
            }
        }

        ShapePath {
            strokeColor: root.colPrimary
            strokeWidth: root.lineWidth
            capStyle: ShapePath.RoundCap
            fillColor: "transparent"

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.radius
                radiusY: root.radius
                startAngle: -90
                sweepAngle: root.clampedValue * 360
            }
        }
    }
}
