import QtQuick
import qs.Components

Item {
    id: root

    property int margins: 3

    height: parent.height
    width: parent.height

    CornerFrame {
        frameSize: 6
        anchors {
            fill: parent
            margins: root.margins
        }
    }
}
