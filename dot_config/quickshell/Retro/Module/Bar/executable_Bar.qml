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
        implicitHeight: mem.implicitHeight + 4

        Rectangle {
            id: frame
            anchors.fill: parent
            color: "#868d80"
            // Canvas {
            //     anchors.fill: parent
            //     onPaint: {
            //         var ctx = getContext("2d");
            //         ctx.reset();
            //         const color = "#3c3c3d";
            //
            //         const bandWidth = height * (1 / 2) / 4 / 2;
            //
            //         for (let i = 0; i < 4; i++) {
            //             ctx.beginPath();
            //             ctx.strokeStyle = color;
            //             ctx.lineWidth = bandWidth;
            //
            //             ctx.moveTo(0, i * bandWidth + bandWidth / 2 + height * (1 / 4) + i * bandWidth);
            //             ctx.lineTo(width, i * bandWidth + bandWidth / 2 + height * (1 / 4) + i * bandWidth);
            //
            //             ctx.stroke();
            //         }
            //     }
            // }
            border.color: "#292523"
            border.width: 2
        }

        Row {
            id: leftPart
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0
            Rectangle {
                id: begMar
                opacity: 1
                anchors.verticalCenter: parent.verticalCenter
                height: mem.implicitHeight
                width: root.speWidth * (1 / 16)
                color: "#868d80"
            }
            Rectangle {
                id: beg
                opacity: 0
                height: mem.height
                width: root.speWidth * (3 / 16)
            }

            Memory {
                id: mem
            }

            Rectangle {
                id: sep1
                opacity: 0
                height: mem.height
                width: root.speWidth
                color: "#3c3836"
            }

            CPU {
                id: cpu
            }

            Rectangle {
                id: sep2
                opacity: 0
                height: mem.height
                width: root.speWidth
                color: "#3c3836"
            }

            Battery {
                id: battery
            }

            Rectangle {
                id: midSep
                opacity: 0
                height: mem.height
                width: root.width - mem.width - cpu.width - time.width - date.width - sep1.width - sep2.width - sep3.width - network.width - battery.width - sep4.width - beg.width - end.width - begMar.width - endMar.width
                color: "#3c3836"
            }

            Network {
                id: network
            }

            Rectangle {
                id: sep3
                opacity: 0
                height: mem.height
                width: root.speWidth
            }

            Time {
                id: time
            }

            Rectangle {
                id: sep4
                opacity: 0
                height: mem.height
                width: root.speWidth
            }

            Date {
                id: date
            }

            Rectangle {
                id: end
                opacity: 0
                height: mem.height
                width: root.speWidth * (3 / 16)
            }
            Rectangle {
                id: endMar
                height: mem.height
                width: root.speWidth * (1 / 16)
                color: "#868d80"
            }
        }
    }
}
