pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Hyprland
import qs.Common

Item {
    id: root
    anchors.verticalCenter: parent.verticalCenter
    height: parent.height - 2
    width: 10 * height
    property string monitorName

    Row {
        id: main
        height: parent.height
        Repeater {
            model: 10
            Workspace {
                required property var index

                Text {

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    property int monitorID: Hyprland.monitors.values.find(m => m.name === root.monitorName).id
                    property var occupied: Hyprland.workspaces.values.find(w => w.id === ((parent.index + 1) + (10 * monitorID)))
                    property bool isFocused: Hyprland.focusedWorkspace?.id === (parent.index + 1 + 10 * monitorID)

                    text: occupied ? "+" : " "

                    color: isFocused ? Theme.accentGreen : "white"
                    font.pointSize: 15
                }
            }
        }
    }
}
