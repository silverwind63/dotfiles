import QtQuick
import qs.Services
import Quickshell.Services.UPower

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
            text: {
                if (UPower.displayDevice.state === UPowerDeviceState.FullyCharged || UPower.displayDevice.state === UPowerDeviceState.Charging) {
                    return "󱐋 " + Math.floor(UPower.displayDevice.percentage * 100).toString().padStart(3, " ") + "%";
                } else {
                    return "󰚦 " + Math.floor(UPower.displayDevice.percentage * 100).toString().padStart(3, " ") + "%";
                }
            }

            font.family: "JetBrainsMono Nerd Font Propo"
            font.pointSize: 12
            color: {
                if (UPower.displayDevice.percentage < 0.75) {
                    return "#dbbc7f";
                } else if (UPower.displayDevice.percentage < 0.5) {
                    return "#e69875";
                } else if (UPower.displayDevice.percentage < 0.25) {
                    return "#e67e80";
                } else {
                    return "#a7c080";
                }
            }
        }
    }
}
