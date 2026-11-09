import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.services

Item {
    implicitWidth: layout.implicitWidth
    implicitHeight: Appearance.barHeight

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        spacing: 4

        Resource {
            iconName: "memory"
            percentage: ResourceUsage.memoryUsedPercentage
            warningThreshold: 90
        }
        Resource {
            iconName: "swap_horiz"
            percentage: ResourceUsage.swapUsedPercentage
            warningThreshold: 90
        }
        Resource {
            iconName: "planner_review"
            percentage: ResourceUsage.cpuUsage
            warningThreshold: 90
        }
    }
}
