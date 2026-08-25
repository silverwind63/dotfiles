import Quickshell
import QtQuick

import "./Common"
import "./Components"

// qmllint disable
PanelWindow {
    id: root

    color: Theme.background

    implicitHeight: 35

    anchors {
        top: true
        right: true
        left: true
    }

    Rectangle {
        anchors.fill: parent
        border {
            width: 1
            color: Theme.ctosGray
        }
        color: "transparent"
    }

    Row {
        anchors.fill: parent

        Divider {
            id: workspaceLeftDiv
            anchors.left: oslabel.right
        }

        Workspaces {
            id: hyprWorkspaces
            anchors.left: workspaceLeftDiv.right
        }

        Divider {
            id: workspaceRightDiv
            anchors.left: hyprWorkspaces.right
        }

        CPU {
            id: cpu
            anchors.left: workspaceRightDiv.right
        }

        Divider {
            id: cpuRightDiv
            anchors.left: cpu.right
        }

        Memory {
            id: mem
            anchors.left: cpuRightDiv.right
        }

        Divider {
            id: memRightDiv
            anchors.left: mem.right
        }

        Time {
            id: time
            anchors.right: parent.right
            anchors.rightMargin: root.height / 6
        }

        Divider {
            id: timeLeftDiv
            anchors.right: time.left
            anchors.rightMargin: root.height / 6
        }

        Battery {
            id: bat
            anchors.right: timeLeftDiv.left
        }

        Divider {
            id: batLeftDiv
            anchors.right: bat.left
            anchors.rightMargin: root.height / 6
        }
        Net {
            id: net
            anchors.right: batLeftDiv.left
        }

        Divider {
            id: netLeftDiv
            anchors.right: net.left
            anchors.rightMargin: root.height / 6
        }
    }
}
