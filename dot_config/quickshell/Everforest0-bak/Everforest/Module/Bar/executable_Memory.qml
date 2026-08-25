import QtQuick
import qs.Services

Rectangle {
    id: root
    implicitWidth: contentBackground.width
    implicitHeight: contentBackground.height
    anchors.verticalCenter: parent.verticalCenter
    color: "transparent"
    Rectangle {
        id: contentBackground
        anchors.top: root.top
        height: content.height * 1.25
        width: content.width + 25
        color: "#1e2326"
        radius: 11

        Text {
            id: content
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: " " + Info.memUsage.toString().padStart(4, " ") + "GB"
            font.family: "JetBrainsMono Nerd Font Propo"
            font.pointSize: 12
            color: "#e69875"
        }
    }
}
