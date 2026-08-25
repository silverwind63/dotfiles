import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Services.UPower
import qs.Common

Item {
    id: root
    height: parent.height
    width: label.width + time.width + leftDiv.width + rightDiv.width

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
                if (!(UPower.onBattery)) {
                    return Theme.gray500;
                } else if (UPower.displayDevice.percentage > 0.5) {
                    return Theme.accentGreen;
                } else {
                    return Theme.accentRed;
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
            id: time
            height: parent.height
            font.family: "JetBrainsMono Nerd Font Mono"
            text: (UPower.displayDevice.percentage * 100).toString()
            color: "white"
            font.pointSize: 15
        }

        Text {
            id: rightDiv
            height: parent.height
            font.family: "JetBrainsMono Nerd Font Mono"
            text: "%" + "]"
            color: Theme.gray500
            font.pointSize: 15
        }
    }
}
