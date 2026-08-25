import QtQuick
import qs.Services
import Quickshell.Services.UPower

Rectangle {
    id: root
    implicitWidth: contentBackground.width
    implicitHeight: contentBackground.height
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {
        id: contentBackground
        anchors.top: root.top
        height: content.height
        width: content.width * 1.25
        color: "#868d80"

        Text {
            id: content
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "BAT: " + (UPower.displayDevice.percentage * 100).toString() + "%"
            font.family: "JetBrainsMono Nerd Font"
            font.pointSize: 12
            color: "#292523"
        }
    }
}
