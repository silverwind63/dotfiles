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
        anchors.horizontalCenter: workspaceIDList.horizontalCenter
        anchors.bottom: windowsList.bottom
        anchors.bottomMargin: -1 * height / 2
        height: 3 * (workspaceIDList.height + windowsList.height)
        width: 4 * (workspaceIDList.height + windowsList.height) + workspaceIDList.width
        color: "#3c3836"
        border.color: "#000000"
        border.width: 2
    }

    // Rectangle {
    //     width: 300
    //     height: 20
    //     anchors.left: topRightRec.left
    //     anchors.bottom: topRightRec.bottom
    //     color: "#689d6a"
    //     border.color: "black"
    //     border.width: 2
    // }
    //
    Rectangle {
        id: topLeftRec
        anchors.top: background.top
        anchors.left: background.left
        width: 20
        height: 20
        color: "#cc241d"
        border.width: 2
        border.color: "black"
    }

    Rectangle {
        id: topRightRec
        anchors.top: background.top
        anchors.right: background.right
        width: 20
        height: 20
        color: "#689d6a"
        border.width: 2
        border.color: "black"
    }

    Rectangle {
        id: downLeftRec
        anchors.bottom: background.bottom
        anchors.left: background.left
        width: 20
        height: 20
        color: "#98971a"
        border.width: 2
        border.color: "black"
    }

    Rectangle {
        id: downRightRec
        anchors.bottom: background.bottom
        anchors.right: background.right
        width: 20
        height: 20
        color: "#d79921"
        border.width: 2
        border.color: "black"
    }

    Row {
        id: workspaceIDList
        anchors.horizontalCenter: parent.horizontalCenter
        // width: prefix.width + workspaceID.width + postfix.width
        height: prefix.height
        Text {
            id: prefix
            text: ""
            font.family: "NMS GeoSans"
            font.pointSize: 15
            color: "#a89984"
        }
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
                        return "#d3869b";
                    } else {
                        return "#928374";
                    }
                }
            }
        }
        Text {
            id: postfix
            text: ""
            font.family: "JetBrainsMono Nerd Font Mono"
            font.pointSize: 15
            color: "#a89984"
        }
    }

    Row {
        id: windowsList
        anchors.top: workspaceIDList.bottom
        anchors.left: workspaceIDList.left
        width: workspaceBar.width
        height: workspaceBar.height

        Repeater {
            id: workspaceBar
            model: root.list
            property int toplevelCount: Hyprland.focusedWorkspace.toplevels.values.length
            Rectangle {
                id: recroot
                required property string modelData
                width: workspaceIDList.width / workspaceBar.toplevelCount
                height: 20
                Row {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: parent.width
                    height: 10
                    Rectangle {
                        height: 10
                        width: recroot.width / 2
                        color: {
                            if (recroot.modelData.slice(2) === root.currentWorkAddr) {
                                return "#427b58";
                            } else {
                                return "#458588";
                            }
                        }
                    }

                    Rectangle {
                        height: 10
                        width: recroot.width / 2
                        color: "#ebdbb2"
                    }
                }

                Row {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    width: parent.width
                    height: 10
                    Rectangle {
                        height: 10
                        width: recroot.width / 2
                        color: "#ebdbb2"
                    }
                    Rectangle {
                        height: 10
                        width: recroot.width / 2
                        color: {
                            if (recroot.modelData.slice(2) === root.currentWorkAddr) {
                                return "#427b58";
                            } else {
                                return "#458588";
                            }
                        }
                    }
                }
            }
        }
    }
}
