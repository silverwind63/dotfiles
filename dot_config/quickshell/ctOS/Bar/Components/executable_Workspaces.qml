pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Hyprland
import "../Common/"

Item {
    id: root
    anchors.verticalCenter: parent.verticalCenter
    height: parent.height - 2
    width: 10 * height

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

                    text: {
                        for (let i = 0; Hyprland.workspaces.values[i]; i++) {
                            if (Hyprland.workspaces.values[i].id == parent.index + 1) {
                                return "+";
                            }
                        }
                        return " ";
                    }

                    color: {
                        if (parent.index + 1 == Hyprland.focusedWorkspace.id) {
                            return Theme.accentGreen;
                        } else {
                            return "white";
                        }
                    }
                    font.pointSize: 15
                }
            }
        }
    }
}
