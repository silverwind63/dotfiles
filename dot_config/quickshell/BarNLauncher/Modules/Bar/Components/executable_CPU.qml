import Quickshell
import QtQuick
import Quickshell.Io
import qs.Common

Item {
    id: root
    height: parent.height
    width: 5 * height

    property real percent

    Row {
        height: parent.height
        width: parent.width

        Text {
            id: label

            height: parent.height / 2
            width: root.width / 2

            font.family: "JetBrainsMono Nerd Font Mono"
            text: "CPU"
            color: "white"
        }
        Text {
            id: percentage

            height: parent.height / 2
            width: root.width / 2

            anchors.left: label.right
            anchors.leftMargin: width / 2

            font.family: "JetBrainsMono Nerd Font Mono"
            text: "[" + root.percent.toFixed().toString() + "%" + "]"
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
                xScale: root.percent / 100
            }
        ]
    }

    Process {
        id: dateProc
        command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'"]
        //command: ["bash", "../Scripts/getCPU.sh"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: root.percent = this.text
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
