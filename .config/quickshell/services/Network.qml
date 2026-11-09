pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool ethernet: false
    property bool wifiEnabled: false
    property string wifiStatus: "disconnected"
    property int strength: 0

    readonly property string materialSymbol: ethernet ? "lan" : wifiStatus === "connected" ? strength > 80 ? "signal_wifi_4_bar" : strength > 55 ? "network_wifi" : strength > 30 ? "network_wifi_2_bar" : "network_wifi_1_bar" : wifiStatus === "connecting" ? "signal_wifi_statusbar_not_connected" : wifiEnabled ? "wifi_find" : "signal_wifi_off"

    function refresh() {
        status.running = true;
        radio.running = true;
        signal.running = true;
    }

    Timer {
        interval: 15000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }

    Process {
        id: monitor
        running: true
        command: ["nmcli", "monitor"]
        stdout: SplitParser {
            onRead: root.refresh()
        }
    }

    Process {
        id: status
        command: ["nmcli", "-t", "-f", "TYPE,STATE", "device", "status"]
        environment: ({
                LANG: "C",
                LC_ALL: "C"
            })
        stdout: StdioCollector {
            onStreamFinished: {
                let ethernet = false;
                let wifi = "disconnected";
                for (const line of text.trim().split("\n")) {
                    const fields = line.split(":");
                    if (fields[0] === "ethernet" && fields[1] === "connected")
                        ethernet = true;
                    if (fields[0] === "wifi") {
                        if (fields[1] === "connected")
                            wifi = "connected";
                        else if (fields[1].includes("connecting"))
                            wifi = "connecting";
                        else if (fields[1] === "unavailable")
                            wifi = "disabled";
                    }
                }
                root.ethernet = ethernet;
                root.wifiStatus = wifi;
            }
        }
    }

    Process {
        id: radio
        command: ["nmcli", "radio", "wifi"]
        environment: ({
                LANG: "C",
                LC_ALL: "C"
            })
        stdout: StdioCollector {
            onStreamFinished: root.wifiEnabled = text.trim() === "enabled"
        }
    }

    Process {
        id: signal
        command: ["nmcli", "-t", "-f", "IN-USE,SIGNAL", "device", "wifi"]
        environment: ({
                LANG: "C",
                LC_ALL: "C"
            })
        stdout: StdioCollector {
            onStreamFinished: {
                const active = text.split("\n").find(line => line.startsWith("*:"));
                root.strength = active ? Number(active.split(":")[1]) || 0 : 0;
            }
        }
    }
}
