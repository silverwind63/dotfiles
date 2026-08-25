pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import qs.Common

TextField {
    id: appNameField

    property alias rem: cursorMetrics.width
    property bool notSearching: text.length === 0

    background: Rectangle {
        id: background
        color: "black"
        border {
            color: Theme.ctosGray
            width: 0
        }
    }

    font {
        pixelSize: 20
        family: "JetBrainsMono Nerd Font"
    }

    echoMode: TextInput.Normal

    TextMetrics {
        id: cursorMetrics
        font: appNameField.font
        text: "▁"
    }

    cursorDelegate: Text {
        id: cursor

        color: appNameField.color
        font: appNameField.font
        text: "▁"

        Timer {
            id: blinkDelayTimer
            interval: 500
            onTriggered: {
                blinkAnimation.running = true;
            }
        }

        Connections {
            target: appNameField

            function onEnabledChanged() {
                if (appNameField.enabled) {
                    blinkDelayTimer.running = true;
                    // don't interrupt mid animation
                } else {
                    blinkDelayTimer.running = false;
                    blinkAnimation.running = false;

                    cursor.opacity = 0;
                }
            }

            function onTextEdited() {
                blinkDelayTimer.restart();
                blinkAnimation.running = false;

                cursor.opacity = 1;
            }
        }

        SequentialAnimation on opacity {
            id: blinkAnimation

            loops: Animation.Infinite

            NumberAnimation {
                from: 1
                to: 1
                duration: 500
            }

            NumberAnimation {
                from: 1
                to: 0
                duration: 300
            }

            NumberAnimation {
                from: 0
                to: 0
                duration: 300
            }
        }
    }

    Component.onDestruction: {
        // in greeter, element will be focused as soon as it is created
        // graceful exit, wayland complains about surface with focus quitting
        appNameField.focus = false;
    }

    Component.onCompleted: {
        appNameField.forceActiveFocus();
    }
}
