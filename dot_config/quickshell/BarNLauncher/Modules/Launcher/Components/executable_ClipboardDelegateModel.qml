pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../../Scripts/fuzzysort.js" as Fuzzy
import qs.Components
import qs.Common
import qs.Services

DelegateModel {
    id: root

    required property string searchKeyword
    property string curretApp
    property int lastIndex: 0
    property int maxString: 30
    property int textWidth: 12
    property int prefixRecSpace: 8
    property int appNameWidth: maxString * textWidth
    property int appToShow: 8
    property int appHeight: 27

    model: Fuzzy.go(searchKeyword, ClipBoard.list, {
        all: true
    }).map(a => a.target)

    delegate: Item {
        id: clipboardRoot
        required property string modelData
        property bool isSelected: ListView.isCurrentItem

        height: appName.height
        width: parent.width
        function decodeAndCopy(): void {
            Quickshell.execDetached(["sh", "-c", `cliphist decode "${modelData}" | wl-copy`]);
        }

        Item {
            Rectangle {
                id: backRec
                width: appName.width + 8
                height: appName.height
                color: "black"
                border.color: "transparent"
                border.width: 0
            }

            Text {
                id: appName
                text: clipboardRoot.modelData.replace(/^\d+\s+/, '').trim()

                color: "white"
                font.pointSize: 15
                font.family: "JetBrainsMono Nerd Font"
                elide: Text.ElideMiddle
            }
        }

        states: [
            State {
                name: "selected"
                when: clipboardRoot.isSelected

                PropertyChanges {
                    backRec {
                        color: "white"
                    }
                    appName {
                        color: "black"
                    }
                }
            }
        ]
    }
}
