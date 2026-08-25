import QtQuick
import Quickshell

Variants {
    model: Quickshell.screens
    PanelWindow {
        id: root

        required property var modelData
        screen: modelData
        anchors {
            left: true
            right: true
            top: true
        }

        property int speWidth: 100

        color: "transparent"

        implicitWidth: 1920
        implicitHeight: mem.height * 1.25
        Rectangle {
            id: frame
            anchors.fill: parent
            color: "#ebdbb2"
        }

        Row {
            id: leftPart
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0
            Rectangle {
                id: beg
                height: mem.height
                width: root.speWidth / 4
                color: "#3c3836"
            }

            Memory {
                id: mem
            }

            Rectangle {
                id: sep1
                height: mem.height
                width: root.speWidth
                color: "#3c3836"
            }

            CPU {
                id: cpu
            }

            Rectangle {
                id: sep2
                height: mem.height
                width: root.speWidth
                color: "#3c3836"
            }

            Battery {
                id: battery
            }

            Rectangle {
                id: midSep
                height: mem.height
                width: root.width - mem.width - cpu.width - time.width - date.width - sep1.width - sep2.width - sep3.width - network.width - battery.width - sep4.width - beg.width - end.width
                color: "#3c3836"
            }

            Network {
                id: network
            }

            Rectangle {
                id: sep3
                height: mem.height
                width: root.speWidth
                color: "#3c3836"
            }

            Time {
                id: time
            }

            Rectangle {
                id: sep4
                height: mem.height
                width: root.speWidth
                color: "#3c3836"
            }

            Date {
                id: date
            }

            Rectangle {
                id: end
                height: mem.height
                width: root.speWidth / 4
                color: "#3c3836"
            }
        }
    }
}
