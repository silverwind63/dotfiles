import QtQuick
import qs.Services

Rectangle {
    id: root
    implicitWidth: prefix.width + textBackground.width + perBackground.width + postfix.width
    implicitHeight: textBackground.height

    Row {

        Rectangle {
            id: prefix
            width: textBackground.height
            height: textBackground.height

            color: "#3c3836"
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    const colors = ["#fb4934", "#fe8019", "#fabd2f", "#83a598"];

                    const bandWidth = height / colors.length;

                    for (let i = 0; i < colors.length; i++) {
                        ctx.beginPath();
                        ctx.strokeStyle = colors[i];
                        ctx.lineWidth = bandWidth;

                        ctx.moveTo(0, i * bandWidth + bandWidth / 2);
                        ctx.lineTo(width, i * bandWidth + bandWidth / 2);

                        ctx.stroke();
                    }
                    ctx.beginPath();
                    ctx.fillStyle = "#3c3836";
                    ctx.moveTo(width, 0);
                    ctx.lineTo(width, height);
                    ctx.lineTo(width / 2, height);
                    ctx.fill();
                }
            }
        }

        Rectangle {
            id: textBackground
            height: (content.height / 4 + 1) * 4
            width: content.width
            color: "#3c3836"

            Text {
                id: content
                anchors.centerIn: parent
                text: "MEM"
                font.family: "NMS GeoSans"
                font.pointSize: 19.5
                color: "#fbf1c7"
            }
        }
        Rectangle {
            id: perBackground
            anchors.top: root.top
            height: textBackground.height
            width: per.width
            color: "#3c3836"

            Text {
                id: per
                anchors.top: parent.top
                text: Info.memUsage
                font.family: "NMS GeoSans"
                font.pointSize: 13
                color: "#fbf1c7"
            }
        }

        Rectangle {
            id: postfix
            width: content.height
            height: textBackground.height

            color: "#3c3836"
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    const colors = ["#fb4934", "#fe8019", "#fabd2f", "#83a598"];

                    const bandWidth = height / colors.length;

                    for (let i = 0; i < colors.length; i++) {
                        ctx.beginPath();
                        ctx.strokeStyle = colors[i];
                        ctx.lineWidth = bandWidth;

                        ctx.moveTo(0, i * bandWidth + bandWidth / 2);
                        ctx.lineTo(width, i * bandWidth + bandWidth / 2);

                        ctx.stroke();
                    }
                    ctx.beginPath();
                    ctx.fillStyle = "#3c3836";
                    ctx.moveTo(0, height);
                    ctx.lineTo(0, 0);
                    ctx.lineTo(width / 2, 0);
                    ctx.fill();
                }
            }
        }
    }
}
