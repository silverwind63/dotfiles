import Quickshell
import QtQuick

Scope {
    PanelWindow {
        id: window
        implicitHeight: 100
        implicitWidth: 1920
        color: "transparent"
        anchors.top: true
        exclusiveZone: 50
        Rectangle {
            id: pill
            color: "#1e2326"
            height: 100
            width: 200
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            Behavior on height {
                NumberAnimation {
                    duration: 500
                }
            }
        }
    }
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            if (pill.height == 100) {
                pill.height = 50;
            } else {
                pill.height = 100;
            }
        }
    }
}
