pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../../scripts/fuzzysort.js" as Fuzzy
import qs.Services

DelegateModel {
    id: root

    property list<string> powerOptions: ["poweroff", "reboot", "suspend"]
    readonly property list<string> powerIcon: ["⏻", "", ""]
    property int iconHeight: powerString.height

    model: Fuzzy.go("", root.powerOptions, {
        all: true
    }).map(a => a.target)

    delegate: Rectangle {
        id: powerRoot
        required property string modelData
        property bool isSelected: ListView.isCurrentItem

        height: 50
        width: powerString.width * 1.5
        function run_cmd(): void {
            Quickshell.execDetached(["sh", "-c", `systemctl "${modelData}"`]);
            GlobalStates.powerMenuOpen = false;
        }
        color: "#414b50"
        radius: 15

        Text {
            id: powerString
            text: root.powerIcon[root.powerOptions.indexOf(powerRoot.modelData.replace(/^\d+\s+/, '').trim())]
            anchors.horizontalCenter: parent.horizontalCenter

            color: "#d3c6aa"
            font.pointSize: 30
            font.family: "JetBrainsMono Nerd Font"
        }

        states: [
            State {
                name: "selected"
                when: powerRoot.isSelected

                PropertyChanges {
                    powerRoot {
                        color: "#A7c080"
                    }
                    powerString {
                        color: "#1e2326"
                    }
                }
            }
        ]

        transitions: Transition {
            ColorAnimation {
                properties: "color,powerString.power"
                duration: 150
            }
        }
    }
}
