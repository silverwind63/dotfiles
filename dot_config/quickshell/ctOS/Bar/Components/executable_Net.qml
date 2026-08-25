import Quickshell
import QtQuick
import Quickshell.Io

import "../Common/"

Item {
    id: root
    height: parent.height
    width: label.width + ssid.width + leftDiv.width + rightDiv.width

    property string ssid
    property int strength

    Row {
        id: main
        height: parent.height
        width: parent.width

        anchors.top: parent.top
        anchors.topMargin: height / 8
        spacing: 0

        Text {
            id: label
            height: parent.height
            anchors.top: parent.top
            anchors.topMargin: height / 7
            font.family: "JetBrainsMono Nerd Font Mono"
            text: "■"
            color: {
                if (root.ssid) {
                    if (root.strength > -40) {
                        return Theme.accentGreen;
                    } else {
                        return Theme.accentRed;
                    }
                } else {
                    return Theme.gray500;
                }
            }
            font.pointSize: 10
        }

        Text {
            id: leftDiv
            height: parent.height
            font.family: "JetBrainsMono Nerd Font Mono"
            text: "["
            color: Theme.gray500
            font.pointSize: 15
        }

        Text {
            id: ssid
            height: parent.height
            font.family: "JetBrainsMono Nerd Font Mono"
            text: {
                if (root.ssid) {
                    return root.ssid.toString();
                } else {
                    return "disconnected";
                }
            }
            color: {
                if (root.ssid) {
                    return "white";
                } else {
                    return Theme.gray500;
                }
            }
            font.pointSize: 15
        }

        Text {
            id: rightDiv
            height: parent.height
            font.family: "JetBrainsMono Nerd Font Mono"
            text: "]"
            color: Theme.gray500
            font.pointSize: 15
        }
    }

    Process {
        id: getssid
        command: ["bash", "-c", "iw dev wlan0 link | grep SSID | awk '{print $2}'"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: root.ssid = this.text
        }
    }

    Process {
        id: getstrength
        command: ["bash", "-c", "iw dev wlan0 link | grep signal | awk '{print $2}'
"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: root.strength = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            getssid.running = true;
            getstrength.running = true;
        }
    }
}
