import QtQuick
import qs.Services

Rectangle {
    id: root
    implicitWidth: prefix.width + timeCol.width + mid.width + dateBackground.width + postfix.width
    implicitHeight: 2 * timeBackground.height

    Row {

        Rectangle {
            id: prefix
            width: root.height
            height: root.height

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
                    ctx.moveTo(width, height / 2);
                    ctx.lineTo(width, height);
                    ctx.lineTo(3 * width / 4, height);
                    ctx.fill();
                }
            }
        }
        Column {
            id: timeCol
            anchors.top: parent.top
            Rectangle {
                // id: prefix
                width: timeBackground.width
                height: timeBackground.height

                color: "#3c3836"
                Canvas {
                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        const colors = ["#fb4934", "#fe8019"];

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
            Rectangle {
                id: timeBackground
                height: (time.height / 2 + 1) * 2
                width: time.height * 2.8 + 10
                color: "#3c3836"
                Text {
                    id: time
                    anchors.centerIn: parent
                    text: Info.time
                    font.family: "NMS GeoSans"
                    font.pointSize: 10
                    color: "#fbf1c7"
                }
            }
        }
        Rectangle {
            id: mid
            width: root.height
            height: root.height

            color: "#3c3836"
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    const colors = ["#fb4934", "#fe8019", "#fbf1c7", "#83a598"];

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
                    ctx.lineTo(width / 4, height / 2);
                    ctx.lineTo(0, height / 2);
                    ctx.fill();

                    ctx.beginPath();
                    ctx.fillStyle = "#3c3836";
                    ctx.moveTo(width, height / 2);
                    ctx.lineTo(width, 0);
                    ctx.lineTo(3 * width / 4, height / 2);
                    ctx.fill();
                }
            }
        }
        Rectangle {
            id: dateBackground
            height: root.height
            width: Math.round(date.height * 4 + 10)
            color: "#3c3836"
            Text {
                id: date
                anchors.top: parent.top
                text: Info.date
                font.family: "NMS GeoSans"
                font.pointSize: 10
                color: "#fbf1c7"
            }
            Canvas {
                anchors.bottom: dateBackground.bottom
                width: parent.width
                height: root.height / 2
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    const colors = ["#fbf1c7", "#83a598"];

                    const bandWidth = root.height / 4;

                    for (let i = 0; i < colors.length; i++) {
                        ctx.beginPath();
                        ctx.strokeStyle = colors[i];
                        ctx.lineWidth = bandWidth;

                        ctx.moveTo(0, i * bandWidth + bandWidth / 2);
                        ctx.lineTo(width, i * bandWidth + bandWidth / 2);

                        ctx.stroke();
                    }
                    console.log("Y: " + y);
                    console.log("X: " + x);
                    console.log("width: " + width);
                    console.log("height: " + height);
                }
            }
        }

        Rectangle {
            id: postfix
            height: root.height
            width: root.height

            color: "#3c3836"
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    const colors = ["#fbf1c7", "#83a598", "#fbf1c7", "#83a598"];

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
                    ctx.moveTo(0, height / 2);
                    ctx.lineTo(width / 4, 0);
                    ctx.lineTo(0, 0);
                    ctx.fill();
                }
            }
        }
    }
}
