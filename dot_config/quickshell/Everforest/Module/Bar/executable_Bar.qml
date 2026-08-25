import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.Services

Variants {
    model: Quickshell.screens
    PanelWindow {
        id: root

        required property var modelData
        screen: modelData

        anchors {
            left: true
            right: true
            top: true
        }

        property int speWidth: 25

        color: "transparent"

        implicitWidth: 1920
        implicitHeight: Screen.height
        exclusiveZone: background.height

        mask: Region {}

        Variants {
            id: regions
            //makes regions by looking at childrenitems
            model: root.contentItem.children

            delegate: Region {
                required property Item modelData
                item: modelData
            }
        }

        WlrLayershell.keyboardFocus: {
            if (GlobalStates.powerMenuOpen || GlobalStates.appsLauncherOpen || GlobalStates.clipboardOpen) {
                WlrKeyboardFocus.Exclusive;
            } else {
                WlrKeyboardFocus.None;
            }
        }

        GlobalShortcut {
            name: "PowerMenu"
            description: "Toggle PowerMenu's visiblity"
            onPressed: {
                GlobalStates.powerMenuOpen = true;
            }
        }

        GlobalShortcut {
            name: "Launcher"
            description: "Toggle launcher's visiblity"
            onPressed: {
                GlobalStates.appsLauncherOpen = true;
            }
        }

        GlobalShortcut {
            name: "Clipboard"
            description: "Toggle clipboard's visiblity"
            onPressed: {
                GlobalStates.clipboardOpen = true;
            }
        }
        Rectangle {
            id: background
            anchors.top: parent.top
            width: 1920
            height: mem.implicitHeight * 1.5
            color: "transparent"

            Row {
                id: leftPart
                anchors.top: parent.top
                anchors.topMargin: mem.implicitHeight * 0.25
                spacing: 0

                Rectangle {
                    id: beg
                    opacity: 0
                    height: mem.height
                    width: root.speWidth * (1 / 4)
                }

                Memory {
                    id: mem
                }

                Rectangle {
                    id: sep1
                    opacity: 0
                    height: mem.height
                    width: root.speWidth
                    color: "#3c3836"
                }

                CPU {
                    id: cpu
                }

                Rectangle {
                    id: sep2
                    opacity: 0
                    height: mem.height
                    width: root.speWidth
                    color: "#3c3836"
                }

                Battery {
                    id: battery
                }

                Rectangle {
                    id: sep4
                    opacity: 0
                    height: mem.height
                    width: root.speWidth
                    color: "#3c3836"
                }
            }
            Workspaces {
                anchors.left: leftPart.right
                focusedScreen: root.modelData.name
            }

            // Windows {
            //     id: windows
            //     anchors.horizontalCenter: parent.horizontalCenter
            //     anchors.verticalCenter: parent.verticalCenter
            //     focusedScreen: root.modelData.name
            // }
            Row {
                id: rightPart
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                spacing: 0

                Network {
                    id: network
                }

                Rectangle {
                    id: sep3
                    opacity: 0
                    height: mem.height
                    width: root.speWidth
                }

                Time {
                    id: time
                }

                Rectangle {
                    id: sep5
                    opacity: 0
                    height: mem.height
                    width: root.speWidth
                }

                Date {
                    id: date
                }

                Rectangle {
                    id: end
                    opacity: 0
                    height: mem.height
                    width: root.speWidth * (1 / 4)
                }
            }
        }
        Loader {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.implicitWidth
            height: parent.implicitHeight
            active: (GlobalStates.appsLauncherOpen || GlobalStates.clipboardOpen) && Hyprland.focusedMonitor.name === root.modelData.name
            sourceComponent: Launcher {
                id: launcher
            }
        }
    }
}
