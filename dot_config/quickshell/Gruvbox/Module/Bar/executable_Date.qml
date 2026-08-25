import QtQuick
import qs.Services

Rectangle {
    id: root
    implicitWidth: contentBackground.width
    implicitHeight: contentBackground.height

    Rectangle {
        id: contentBackground
        anchors.top: root.top
        height: content.height
        width: content.width
        color: "#3c3836"

        Text {
            id: content
            anchors.top: parent.top
            text: "Date: " + Info.date
            font.family: "NMS GeoSans"
            font.pointSize: 15
            color: "#fbf1c7"
        }
    }
}
