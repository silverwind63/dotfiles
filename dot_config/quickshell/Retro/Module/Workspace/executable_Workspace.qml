pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import qs.Services

Rectangle {
    id: root
    width: 300
    height: 500
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    property list<string> list: []
    property string currentWorkAddr: Hyprland.focusedWorkspace.toplevels.values.find(t => t.activated).address

    color: "transparent"

    Rectangle {
        id: backBorder
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: background.height + 10
        width: background.width + 10
        color: "#908b79"
        border.color: "#292523"
        border.width: 3
    }
    Rectangle {
        id: background
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 2 * (workspaceIDList.height + windowsList.height)
        width: height + (workspaceIDList.width > windowsList.width ? workspaceIDList.width : windowsList.width)
        color: "#3c3c3d"
        border.color: "#292523"
        border.width: 3
    }

    Column {
        id: contentColumn
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -0.5 * (workspaceIDList.height + windowsList.height)
        Row {
            id: workspaceIDList
            anchors.horizontalCenter: parent.horizontalCenter
            // width: prefix.width + workspaceID.width + postfix.width
            spacing: 5
            Repeater {
                id: workspaceID
                property int workspaceCount: Hyprland.workspaces.values.filter(w => w.id > (10 * Hyprland.focusedMonitor.id) && w.id < (10 * (Hyprland.focusedMonitor.id + 1))).length
                model: Hyprland.workspaces.values.filter(w => w.id > (10 * Hyprland.focusedMonitor.id) && w.id < (10 * (Hyprland.focusedMonitor.id + 1)))
                Rectangle {
                    id: workspaceBack
                    required property var modelData
                    required property int index
                    height: workspace.height * 1.25
                    width: workspace.width * 2

                    color: {
                        if (modelData.id == Hyprland.focusedWorkspace.id) {
                            return "#908b79";
                        } else {
                            return "#3c3836";
                        }
                    }
                    border.width: 2
                    Text {
                        id: workspace
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: parent.modelData.id % 10
                        font.family: "JetBrainsMono Nerd Font"
                        font.pointSize: 15
                        color: {
                            if (parent.modelData.id == Hyprland.focusedWorkspace.id) {
                                return "#292523";
                            } else {
                                return "#908b79";
                            }
                        }
                    }
                }
            }
        }

        Row {
            id: windowsList
            anchors.top: workspaceIDList.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 2

            Repeater {
                id: workspaceBar
                model: Hyprland.focusedWorkspace.toplevels.values[0] ? root.list : 1
                Rectangle {
                    id: recroot
                    required property string modelData
                    width: 20
                    height: 20
                    color: "#908b79"

                    Rectangle {
                        opacity: {
                            if (parent.modelData.slice(2) === root.currentWorkAddr && Hyprland.focusedWorkspace.toplevels.values != 0) {
                                return 1;
                            } else {
                                return 0;
                            }
                        }

                        width: parent.width / 2
                        height: parent.height / 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#292523"
                    }
                    opacity: {
                        if (Hyprland.focusedWorkspace.toplevels.values != 0) {
                            return 1;
                        } else {
                            return 0;
                        }
                    }

                    border.color: "#292523"
                    border.width: 2
                }
            }
        }
    }

    Socket {
        path: `/run/user/1000/hypr/${Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")}/.socket2.sock`
        connected: true

        parser: SplitParser {
            onRead: msg => {
                getAddrProc.running = true;
            }
        }
    }

    Process {
        id: getAddrProc
        command: ["hyprctl", "clients", "-j"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.list = parseClients(text);
            }
        }
    }

    function parseClients(jsonText) {
        var clients = JSON.parse(jsonText);

        // equivalent of:
        // (map(select(.focusHistoryID == 0))[0].workspace.id)

        var ws = null;
        for (var i = 0; i < clients.length; i++) {
            if (clients[i].focusHistoryID === 0) {
                ws = clients[i].workspace.id;
                break;
            }
        }

        if (ws === null)
            return [];

        // map(select(.workspace.id == $ws))
        var filtered = clients.filter(c => c.workspace.id === ws);

        // sort_by(.at[0])
        filtered.sort((a, b) => a.at[0] - b.at[0]);

        // .[] | "\(.address)"
        return filtered.map(c => c.address);
    }
}
