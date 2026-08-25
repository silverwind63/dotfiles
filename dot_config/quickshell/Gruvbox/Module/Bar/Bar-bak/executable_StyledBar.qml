import QtQuick
import Quickshell

PanelWindow {
    id: root
    property int decorWidth: 100
    anchors {
        left: true
        right: true
        top: true
    }

    color: "transparent"

    implicitWidth: 1920
    implicitHeight: 35

    Row {
        id: leftPart
        spacing: 0

        Memory {
            id: cpu
        }

        Rectangle {
            id: leftDecor
            width: root.decorWidth
            height: cpu.implicitHeight
            color: "transparent"
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    const colors = ["#fb4934", "#fe8019", "#fabd2f", "#83a598"];

                    const centerX = 0;
                    const centerY = 0;

                    const bandWidth = height / colors.length;

                    for (let i = 0; i < colors.length; i++) {
                        ctx.beginPath();
                        ctx.strokeStyle = colors[i];
                        ctx.lineWidth = bandWidth;

                        ctx.moveTo(0, i * bandWidth + bandWidth / 2);
                        ctx.lineTo(width, i * bandWidth + bandWidth / 2);

                        ctx.stroke();
                    }
                }
            }
        }

        Time {
            id: time
        }

        Rectangle {
            width: root.implicitWidth - time.width - cpu.width - leftDecor.width
            height: cpu.implicitHeight
            color: "transparent"
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    const colors = ["#fbf1c7", "#83a598", "#fbf1c7", "#83a598"];

                    const centerX = 0;
                    const centerY = 0;

                    const bandWidth = height / colors.length;

                    for (let i = 0; i < colors.length; i++) {
                        ctx.beginPath();
                        ctx.strokeStyle = colors[i];
                        ctx.lineWidth = bandWidth;

                        ctx.moveTo(0, i * bandWidth + bandWidth / 2);
                        ctx.lineTo(width, i * bandWidth + bandWidth / 2);

                        ctx.stroke();
                    }
                }
            }
        }
    }
}
