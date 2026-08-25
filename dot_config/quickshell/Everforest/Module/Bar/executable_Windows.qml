pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.Services

Rectangle {
    id: root

    property string focusedScreen
    property list<string> list: []
    property int count: 0

    implicitWidth: contentBackground.width
    implicitHeight: contentBackground.height
    anchors.verticalCenter: parent.verticalCenter
    color: "transparent"
    Rectangle {
        id: contentBackground
        anchors.top: root.top

        height: 30
        width: (root.list.length > 1 ? root.list.length : 1) * 35 + 50
        color: "#1e2326"
        radius: 13
        Rectangle {
            id: windowRec
            anchors.verticalCenter: parent.verticalCenter
            property int prevIndex: 0
            property int tempWidth
            //property int objectCount: root.list.length

            width: 35
            height: 18
            color: "#a7c080"
            radius: 8
            x: windowRec.x = 25 + 35 * Math.max(root.list.indexOf("0"), 0)
            opacity: root.focusedScreen === Hyprland.focusedMonitor.name && root.list.length !== 0

            Behavior on opacity {
                ParallelAnimation {
                    NumberAnimation {
                        duration: 150
                    }
                }
            }

            Behavior on x {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: 150
            }
        }
    }

    Process {
        id: getAddrProc
        command: ["hyprctl", "clients", "-j"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                if (Hyprland.focusedMonitor.name === root.focusedScreen) {
                    root.list = root.parseClients(text);
                }
            }
        }
    }

    function parseClients(jsonText) {
        var clients = JSON.parse(jsonText);

        // equivalent of:
        // (map(select(.focusHistoryID == 0))[0].workspace.id)

        var ws = Hyprland.monitors.values.find(m => m.name === root.focusedScreen).activeWorkspace.id;

        if (ws === null)
            return [];

        // map(select(.workspace.id == $ws))
        var filtered = clients.filter(c => c.workspace.id === ws);

        // sort_by(.at[0])
        filtered.sort((a, b) => a.at[0] - b.at[0]);

        // .[] | "\(.address)"
        return filtered.map(c => c.focusHistoryID);
    }

    Connections {
        target: Hyprland

        function onRawEvent(event: HyprlandEvent): void {
            if (event.name === "activewindowv2") {
                getAddrProc.running = true;
            }
        }
    }
}
