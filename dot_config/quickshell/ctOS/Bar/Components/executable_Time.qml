import Quickshell
import QtQuick
import Quickshell.Io

import "../Common/"

Item {
    id: root
    height: parent.height
    width: label.width + time.width + date.width

    property string time
    property int date
    property string crypt

    Row {
        id: main
        height: parent.height
        width: parent.width

        anchors.top: parent.top
        anchors.topMargin: height / 8
        spacing: 0

        Text {
            id: date
            height: parent.height
            font.family: "JetBrainsMono Nerd Font Mono"
            text: root.date.toString()
            color: "white"
            font.pointSize: 15
        }

        Text {
            id: label
            height: parent.height
            font.family: "JetBrainsMono Nerd Font Mono"
            text: "-" + root.crypt.replace(/\n$/, "") + "-"
            color: Theme.gray500
            font.pointSize: 15
        }

        Text {
            id: time
            height: parent.height
            font.family: "JetBrainsMono Nerd Font Mono"
            text: root.time.toString()
            color: "white"
            font.pointSize: 15
        }
    }

    Process {
        id: dateProc
        command: ["date", "+%Y%m%d"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: root.date = this.text
        }
    }

    Process {
        id: crypt
        command: ["bash", "-c", "echo $$ | sha256sum | cut -c1-8"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: root.crypt = this.text
        }
    }

    Process {
        id: timeProc
        command: ["date", "+%H%M%S"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: root.time = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            dateProc.running = true;
            timeProc.running = true;
        }
    }
}
