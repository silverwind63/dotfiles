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

    Rectangle {
        id: background
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 2 * (workspaceIDList.height + windowsList.height)
        width: height + (workspaceIDList.width > windowsList.width ? workspaceIDList.width : windowsList.width)
        color: "#f9f5d7"
        border.color: "#282828"
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
            Repeater {
                id: workspaceID
                property int workspaceCount: Hyprland.workspaces.values.filter(w => w.id > (10 * Hyprland.focusedMonitor.id) && w.id < (10 * (Hyprland.focusedMonitor.id + 1))).length
                model: Hyprland.workspaces.values.filter(w => w.id > (10 * Hyprland.focusedMonitor.id) && w.id < (10 * (Hyprland.focusedMonitor.id + 1)))
                Text {
                    id: workspace
                    required property var modelData
                    required property int index
                    text: {
                        if (index + 1 === workspaceID.workspaceCount) {
                            return modelData.id % 10;
                        } else {
                            return modelData.id % 10 + "  ";
                        }
                    }
                    font.family: "NMS GeoSans"
                    font.pointSize: 15
                    color: {
                        if (modelData.id == Hyprland.focusedWorkspace.id) {
                            return "#7daea3";
                        } else {
                            return "#7c6f64";
                        }
                    }
                }
            }
        }

        Row {
            id: windowsList
            anchors.top: workspaceIDList.bottom
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
                    color: {
                        if (modelData.slice(2) === root.currentWorkAddr) {
                            return "#83a598";
                        } else {
                            return "#bdae93";
                        }
                    }
                }
            }
        }
    }
}
