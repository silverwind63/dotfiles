import Quickshell
import QtQuick

Item {
    Row {
        Repeater {
            model: 3
            Column {
                required property var index
                model: 3
                Rectangle {
                    required property var index
                }
            }
        }
    }
}
