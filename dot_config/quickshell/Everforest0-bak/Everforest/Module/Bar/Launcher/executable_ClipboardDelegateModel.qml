pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../../scripts/fuzzysort.js" as Fuzzy
import qs.Services

DelegateModel {
    id: root

    required property string searchKeyword
    property int width

    model: Fuzzy.go(searchKeyword, ClipBoard.list, {
        all: true
    }).map(a => a.target)

    delegate: Rectangle {
        id: clipboardRoot
        required property string modelData
        required property int index
        property bool isSelected: ListView.isCurrentItem

        height: copyString.height * 2
        width: parent.width
        function decodeAndCopy(): void {
            Quickshell.execDetached(["sh", "-c", `cliphist decode "${modelData}" | wl-copy`]);
            GlobalStates.clipboardOpen = false;
        }
        color: "#1e2326"
        radius: 15

        Text {
            id: copyString
            width: parent.width * (5 / 6)
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 12
            anchors.top: parent.top
            anchors.topMargin: height / 2
            text: clipboardRoot.modelData.replace(/^\d+\s+/, '').trim()

            color: "#d3c6aa"
            font.pointSize: 12
            font.family: "JetBrainsMono Nerd Font"
            elide: Text.ElideRight
        }

        states: [
            State {
                name: "selected"
                when: clipboardRoot.isSelected

                PropertyChanges {
                    clipboardRoot {
                        color: "#A7c080"
                    }
                    copyString {
                        color: "#282828"
                    }
                }
            }
        ]

        Behavior on color {
            ColorAnimation {
                duration: clipboardRoot.index === 0 ? 0 : 150
            }
        }
    }
}
