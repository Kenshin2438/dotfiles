import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.services

Item {
    id: root

    implicitWidth: layout.implicitWidth
    implicitHeight: Appearance.barHeight

    function formatUsage(total, free) {
        const used = total - free;
        return `${(used / 1048576).toFixed(1)} / ${(total / 1048576).toFixed(1)} GiB`;
    }

    function formatCpuUsage() {
        return [`CPU 总体：${Math.round(ResourceUsage.cpuUsage * 100)}%`, ...ResourceUsage.cpuCoreUsages.map((usage, core) => `核心 ${core}：${Math.round(usage * 100)}%`)].join("\n");
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        spacing: 8

        Resource {
            iconName: "memory"
            percentage: ResourceUsage.memoryUsedPercentage
            warningThreshold: 90
            tooltipText: `内存：${root.formatUsage(ResourceUsage.memoryTotal, ResourceUsage.memoryFree)}\nSWAP：${ResourceUsage.swapTotal > 0 ? root.formatUsage(ResourceUsage.swapTotal, ResourceUsage.swapFree) : "未启用"}`
        }
        Resource {
            iconName: "planner_review"
            percentage: ResourceUsage.cpuUsage
            warningThreshold: 90
            tooltipText: root.formatCpuUsage()
        }
    }
}
