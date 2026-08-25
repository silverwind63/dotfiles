import Quickshell
import QtQuick
import Quickshell.Io
import qs.Common

Item {
    id: root
    height: parent.height
    width: 5 * height

    property real percent
    property real usage

    Row {
        height: parent.height
        width: parent.width

        Text {
            id: label
            //anchors.top: root.top
            //anchors.left: root.left
            height: parent.height / 2
            width: root.width / 2

            font.family: "JetBrainsMono Nerd Font Mono"
            text: "MEM"
            color: "white"
        }
        Text {
            id: percentage
            //anchors.top: root.top
            //anchors.left: label.left
            //anchors.right: root.right
            height: parent.height / 2
            width: root.width / 2

            anchors.left: label.right
            anchors.leftMargin: width / 5

            font.family: "JetBrainsMono Nerd Font Mono"
            text: "[" + root.usage.toString() + "GB" + "]"
            color: "white"
        }
    }

    Rectangle {
        id: barBack

        height: root.height / 6
        width: root.width * 0.96
        anchors.left: root.left
        anchors.bottom: root.bottom
        anchors.bottomMargin: root.height / 6
        anchors.leftMargin: root.width / 50
        anchors.rightMargin: root.width / 50
        color: Theme.textSecondary
    }

    Rectangle {
        id: percentBar

        height: root.height / 6
        width: root.width * 0.96
        anchors.left: root.left
        anchors.bottom: root.bottom
        anchors.bottomMargin: root.height / 6
        anchors.leftMargin: width / 50
        anchors.rightMargin: root.width / 50
        color: Theme.textPrimary

        transformOrigin: Item.Left
        transform: [
            Scale {
                id: progressX
                origin.x: 0
                xScale: root.percent
            }
        ]
    }

    Process {
        id: memUse
        command: ["sh", "-c", "free -m | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                let parts = data.trim().split(/\s+/);
                let total = parseInt(parts[1]) || 1;
                let used = parseInt(parts[2]) || 0;
                root.percent = used / total;
                root.usage = Math.round((used / 1024) * 10) / 10;
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            memUse.running = true;
        }
    }
}
