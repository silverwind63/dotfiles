pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.Services
import QtQuick.Layouts
import qs.Module.Bar.Launcher

Rectangle {
    id: root

    property string focusedScreen

    implicitWidth: contentBackground.width
    implicitHeight: contentBackground.height
    anchors.top: parent.top
    anchors.topMargin: 30 * 0.25
    color: "transparent"
    Rectangle {
        id: contentBackground
        anchors.top: root.top

        height: 30
        width: main.width + 30

        states: [
            State {
                name: "powermenu"
                when: GlobalStates.powerMenuOpen && Hyprland.focusedMonitor.name === root.focusedScreen
                PropertyChanges {
                    contentBackground {
                        width: 250
                        height: 80
                    }
                    main {
                        opacity: 0
                    }
                }
            },
            State {
                name: "launcher"
                PropertyChanges {
                    contentBackground {
                        width: 400
                        height: 300
                    }
                    main {
                        opacity: 0
                    }
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "powermenu"
                reversible: false
                SequentialAnimation {
                    NumberAnimation {
                        duration: 150
                    }
                    NumberAnimation {
                        properties: "width,height"
                        duration: 150
                    }
                }
            },
            Transition {
                from: "powermenu"
                to: ""
                reversible: false
                SequentialAnimation {
                    NumberAnimation {
                        properties: "width,height"
                        duration: 150
                    }
                    NumberAnimation {
                        properties: "main.opacity"
                        duration: 150
                    }
                }
            },
            Transition {
                from: ""
                to: "launcher"
                reversible: false
                SequentialAnimation {
                    NumberAnimation {
                        duration: 150
                    }
                    NumberAnimation {
                        properties: "width,height"
                        duration: 150
                    }
                }
            },
            Transition {
                from: "launcher"
                to: ""
                reversible: false
                SequentialAnimation {
                    NumberAnimation {
                        properties: "width,height"
                        duration: 150
                    }
                    NumberAnimation {
                        properties: "main.opacity"
                        duration: 150
                    }
                }
            }
        ]
        Loader {
            id: powerMenu
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.implicitWidth
            height: parent.implicitHeight
            active: GlobalStates.powerMenuOpen && Hyprland.focusedMonitor.name === root.focusedScreen
            sourceComponent: MainMenu {
                id: mainmenu
                anchors.verticalCenter: contentBackground.verticalCenter
                anchors.horizontalCenter: contentBackground.horizontalCenter
            }
        }
        /*
        Loader {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.implicitWidth
            height: parent.implicitHeight
            active: GlobalStates.appsLauncherOpen && Hyprland.focusedMonitor.name === root.focusedScreen
            sourceComponent: Launcher {
                id: launcher
            }
        }
        */
        color: "#1e2326"
        radius: 13
        Row {
            id: main
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 1
            spacing: 8
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
            Repeater {
                model: 10
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    required property var index
                    property int monitorID: Hyprland.monitors.values.find(m => m.name === root.focusedScreen).id
                    property var occupied: Hyprland.workspaces.values.find(w => w.id === ((index + 1) + (10 * monitorID)))
                    property bool isFocused: Hyprland.focusedWorkspace?.id === (index + 1 + 10 * monitorID)

                    color: {
                        if (isFocused) {
                            return "#d3c6aa";
                        } else if (occupied) {
                            return "#374145";
                        } else {
                            return "#1e2326";
                        }
                    }
                    width: 20
                    height: 20
                    radius: 6
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: parent.index + 1
                        color: {
                            if (parent.isFocused) {
                                return "#1e2326";
                            } else {
                                return "#d3c6aa";
                            }
                        }
                    }
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
            }
        }
    }
}
