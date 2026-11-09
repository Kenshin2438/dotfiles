pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import qs.modules.common
import qs.modules.common.widgets
import qs.services

MouseArea {
    id: root

    required property var screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    readonly property var liveMonitorData: HyprlandData.monitors.find(item => item.id === monitor?.id)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    readonly property int activeWorkspace: monitor?.activeWorkspace?.id ?? 1
    readonly property int fakeWorkspace: activeWindow?.activated ? -9999 : activeWorkspace
    readonly property int shownCount: 10
    readonly property int group: Math.floor((Math.max(1, activeWorkspace) - 1) / shownCount)
    readonly property int workspaceIndexInGroup: (activeWorkspace - 1) % shownCount
    readonly property var occupied: Array.from({
            length: shownCount
        }, (_, index) => Hyprland.workspaces.values.some(item => item.id === workspaceId(index)))
    readonly property var biggestWindow: occupied.map((_, index) => HyprlandData.biggestWindowForWorkspace(workspaceId(index)))
    readonly property string specialWorkspaceName: liveMonitorData?.specialWorkspace?.name.replace("special:", "") ?? ""
    readonly property bool specialWorkspaceActive: specialWorkspaceName !== ""
    property real specialBlur: specialWorkspaceActive ? 1 : 0
    property int workspaceButtonWidth: 24
    readonly property int activeWorkspaceMargin: 2
    readonly property int activeWorkspaceSize: workspaceButtonWidth - activeWorkspaceMargin * 2
    readonly property int workspaceIconSize: 16
    readonly property int hoverIndex: Math.max(0, Math.min(shownCount - 1, Math.floor(mouseX / workspaceButtonWidth)))

    implicitWidth: occupiedIndicators.implicitWidth
    implicitHeight: Appearance.barHeight
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.BackButton

    function workspaceId(index) {
        return group * shownCount + index + 1;
    }

    onPressed: event => {
        if (event.button === Qt.LeftButton)
            Hyprland.dispatch(`hl.dsp.focus({workspace = ${workspaceId(hoverIndex)}})`);
        else if (event.button === Qt.BackButton)
            Hyprland.dispatch('hl.dsp.workspace.toggle_special("magic")');
    }
    onWheel: event => {
        if (event.angleDelta.y < 0)
            Hyprland.dispatch('hl.dsp.focus({workspace = "r+1"})');
        else if (event.angleDelta.y > 0)
            Hyprland.dispatch('hl.dsp.focus({workspace = "r-1"})');
    }

    Behavior on specialBlur {
        SmoothNumberAnimation {}
    }

    Item {
        id: regularWorkspaces

        anchors.fill: parent
        scale: 1 - 0.08 * root.specialBlur
        layer.enabled: root.specialBlur > 0
        layer.smooth: true
        layer.effect: MultiEffect {
            brightness: -0.1 * root.specialBlur
            blurEnabled: true
            blur: root.specialBlur
            blurMax: 32
        }

        Rectangle {
            id: occupiedIndicatorsBg
            anchors.fill: parent
            color: Appearance.transparentize(Appearance.colSecondaryContainer, 0.4)
            visible: false
        }

        Row {
            id: occupiedIndicators
            anchors.centerIn: parent
            spacing: 0
            layer.enabled: true
            visible: false

            Repeater {
                model: root.shownCount

                delegate: Item {
                    id: workspaceBackground

                    required property int index
                    readonly property int workspaceId: root.workspaceId(index)
                    readonly property bool currentOccupied: root.occupied[index] && workspaceId !== root.fakeWorkspace
                    readonly property bool previousOccupied: index > 0 && root.occupied[index - 1] && workspaceId - 1 !== root.fakeWorkspace
                    readonly property bool nextOccupied: index < root.shownCount - 1 && root.occupied[index + 1] && workspaceId + 1 !== root.fakeWorkspace

                    implicitWidth: root.workspaceButtonWidth
                    implicitHeight: root.workspaceButtonWidth

                    Pill {
                        property real baseWidth: root.workspaceButtonWidth * workspaceBackground.currentOccupied
                        property real length: root.workspaceButtonWidth * (1 + 0.5 * workspaceBackground.previousOccupied + 0.5 * workspaceBackground.nextOccupied) * workspaceBackground.currentOccupied
                        property real offset: (!workspaceBackground.currentOccupied ? 0.5 : -0.5 * workspaceBackground.previousOccupied) * root.workspaceButtonWidth

                        anchors.verticalCenter: parent.verticalCenter
                        x: offset
                        implicitWidth: length
                        implicitHeight: baseWidth
                        Behavior on baseWidth {
                            SmoothNumberAnimation {}
                        }
                        Behavior on length {
                            SmoothNumberAnimation {}
                        }
                        Behavior on offset {
                            SmoothNumberAnimation {}
                        }
                    }
                }
            }
        }

        MaskMultiEffect {
            anchors.centerIn: parent
            implicitWidth: occupiedIndicators.implicitWidth
            implicitHeight: occupiedIndicators.implicitHeight
            source: occupiedIndicatorsBg
            maskSource: occupiedIndicators
        }

        WorkspaceIndicator {
            id: activeIndicator
            z: 2
            index: root.workspaceIndexInGroup
            buttonWidth: root.workspaceButtonWidth
            indicatorSize: root.activeWorkspaceSize
        }

        WorkspaceIndicator {
            id: interactionIndicator
            z: 3
            index: root.containsMouse ? root.hoverIndex : root.workspaceIndexInGroup
            buttonWidth: root.workspaceButtonWidth
            indicatorSize: root.activeWorkspaceSize
            color: "transparent"

            Rectangle {
                anchors.fill: interactionIndicator.indicatorRectangle
                radius: root.activeWorkspaceSize / 2
                color: Appearance.transparentize(Appearance.colPrimary, root.containsPress ? 0.65 : root.containsMouse ? 0.82 : 1)
            }
        }

        Row {
            id: numbersGrid
            z: 4
            spacing: 0
            layer.enabled: true

            Repeater {
                model: root.shownCount
                delegate: NumberWorkspaceItem {
                    workspaceRoot: root
                }
            }
        }

        Colorizer {
            z: 5
            anchors.fill: numbersGrid
            colorizationColor: Appearance.colOnPrimary
            sourceColor: Appearance.colOnSecondaryContainer
            source: activeIndicator
            maskEnabled: true
            maskSource: numbersGrid
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }

        Row {
            id: appsGrid
            z: 6
            spacing: 0

            Repeater {
                model: root.shownCount

                delegate: WorkspaceItem {
                    id: workspaceApp
                    workspaceRoot: root

                    IconImage {
                        id: appIcon
                        property real cornerMargin: workspaceApp.hasIcon ? (root.workspaceButtonWidth - root.workspaceIconSize) / 2 : -4

                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.bottomMargin: (parent.implicitHeight - root.workspaceButtonWidth) / 2 + cornerMargin
                        anchors.rightMargin: (parent.implicitWidth - root.workspaceButtonWidth) / 2 + cornerMargin
                        source: workspaceApp.iconPath
                        implicitSize: root.workspaceIconSize
                        asynchronous: true
                        visible: false
                        layer.enabled: true
                        Behavior on cornerMargin {
                            SmoothNumberAnimation {}
                        }
                    }

                    Circle {
                        id: iconMask
                        visible: false
                        layer.enabled: true
                        diameter: appIcon.implicitSize
                    }

                    Loader {
                        anchors.fill: appIcon
                        active: workspaceApp.hasIcon
                        sourceComponent: Colorizer {
                            implicitWidth: appIcon.implicitWidth
                            implicitHeight: appIcon.implicitHeight
                            colorizationColor: Appearance.colOnSecondaryContainer
                            colorization: 0.8
                            brightness: 0
                            source: appIcon
                            visible: workspaceApp.hasIcon
                            maskEnabled: true
                            maskSource: iconMask
                            maskThresholdMin: 0.5
                            maskSpreadAtMin: 1
                        }
                    }
                }
            }
        }
    }

    FadeLoader {
        anchors.centerIn: parent
        shown: root.specialWorkspaceActive
        scale: 0.8 + 0.2 * root.specialBlur
        opacity: root.specialBlur

        sourceComponent: Pill {
            anchors.centerIn: parent
            implicitWidth: specialText.implicitWidth + 20
            implicitHeight: 20
            color: Appearance.colPrimary

            StyledText {
                id: specialText
                anchors.centerIn: parent
                text: root.specialWorkspaceName
                color: Appearance.colOnPrimary
                font.pixelSize: 12
            }
        }
    }
}
