pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real memoryTotal: 1
    property real memoryFree: 0
    readonly property real memoryUsedPercentage: (memoryTotal - memoryFree) / memoryTotal
    property real swapTotal: 1
    property real swapFree: 0
    readonly property real swapUsedPercentage: swapTotal > 0 ? (swapTotal - swapFree) / swapTotal : 0
    property real cpuUsage: 0
    property var previousCpuStats: null

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            meminfo.reload();
            stat.reload();

            const memory = meminfo.text();
            root.memoryTotal = Number(memory.match(/MemTotal: *(\d+)/)?.[1] ?? 1);
            root.memoryFree = Number(memory.match(/MemAvailable: *(\d+)/)?.[1] ?? 0);
            root.swapTotal = Number(memory.match(/SwapTotal: *(\d+)/)?.[1] ?? 0);
            root.swapFree = Number(memory.match(/SwapFree: *(\d+)/)?.[1] ?? 0);

            const cpuLine = stat.text().match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);
            if (!cpuLine)
                return;
            const stats = cpuLine.slice(1).map(Number);
            const total = stats.reduce((sum, value) => sum + value, 0);
            const idle = stats[3] + stats[4];
            if (root.previousCpuStats) {
                const totalDiff = total - root.previousCpuStats.total;
                const idleDiff = idle - root.previousCpuStats.idle;
                root.cpuUsage = totalDiff > 0 ? 1 - idleDiff / totalDiff : 0;
            }
            root.previousCpuStats = ({
                    total: total,
                    idle: idle
                });
        }
    }

    FileView {
        id: meminfo
        path: "/proc/meminfo"
    }

    FileView {
        id: stat
        path: "/proc/stat"
    }
}
