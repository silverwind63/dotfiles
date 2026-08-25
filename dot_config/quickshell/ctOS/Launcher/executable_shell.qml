import Quickshell
import QtQuick
import Quickshell.Wayland

import "./Common"
import "./Components"

// qmllint disable
PanelWindow {
    id: root

    color: Theme.background

    implicitHeight: 350
    implicitWidth: 350

    anchors {
        top: fals
        right: false
        left: false
        bottom: false
    }

    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    Rectangle {
        anchors.fill: parent
        border {
            width: 1
            color: Theme.ctosGray
        }
        color: "transparent"
    }
}
