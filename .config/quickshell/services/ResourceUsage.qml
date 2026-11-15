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
    property real cpuUsage: 0
    property var cpuCoreUsages: []
    property var previousCpuStats: null
    property var previousCpuCoreStats: ({})

    function parseCpuStats(line) {
        const stats = line.trim().split(/\s+/).slice(1, 8).map(Number);
        return ({
                total: stats.reduce((sum, value) => sum + value, 0),
                idle: stats[3] + stats[4]
            });
    }

    function calculateCpuUsage(current, previous) {
        if (!previous)
            return 0;
        const totalDiff = current.total - previous.total;
        const idleDiff = current.idle - previous.idle;
        return totalDiff > 0 ? 1 - idleDiff / totalDiff : 0;
    }

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

            const cpuLines = stat.text().split("\n").filter(line => /^cpu\d*\s/.test(line));
            if (cpuLines.length === 0)
                return;

            const stats = root.parseCpuStats(cpuLines[0]);
            root.cpuUsage = root.calculateCpuUsage(stats, root.previousCpuStats);
            root.previousCpuStats = stats;

            const coreUsages = [];
            const coreStats = ({});
            for (const line of cpuLines.slice(1)) {
                const core = Number(line.match(/^cpu(\d+)/)[1]);
                const current = root.parseCpuStats(line);
                coreUsages[core] = root.calculateCpuUsage(current, root.previousCpuCoreStats[core]);
                coreStats[core] = current;
            }
            root.cpuCoreUsages = coreUsages;
            root.previousCpuCoreStats = coreStats;
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
