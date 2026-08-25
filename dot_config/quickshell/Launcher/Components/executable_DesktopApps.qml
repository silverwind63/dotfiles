pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../../Scripts/fuzzysort.js" as Fuzzy
import qs.Components
import qs.Common
import qs.Services

ListView {
    id: root
    width: appNameWidth + prefixRecSpace
    height: appToShow * appHeight

    required property string searchKeyword
    property string curretApp
    property int lastIndex: 0
    property int maxString: 30
    property int textWidth: 12
    property int prefixRecSpace: 8
    property int appNameWidth: maxString * textWidth
    property int appToShow: 8
    property int appHeight: 27

    model: Fuzzy.go(searchKeyword, DesktopEntries.applications.values, {
        all: true,
        keys: ["name", "genericName"]
    }).map(a => a.obj)

    delegate: Item {
        id: appRoot
        required property DesktopEntry modelData
        property bool isSelected: ListView.isCurrentItem

        height: appName.height
        width: parent.width
        function executeApp(): void {
            Quickshell.execDetached({
                command: modelData.runInTerminal ? ["kitty", modelData.command] : modelData.command,
                workingDirectory: modelData.workingDirectory
            });
        }

        Item {
            Rectangle {
                id: prefixRec
                width: appName.width + 8
                height: appName.height
                color: "black"
                border.color: "transparent"
                border.width: 0
            }

            Text {
                id: appName
                text: {
                    return appRoot.modelData.name;
                }

                color: "white"
                font.pointSize: 15
                font.family: "JetBrainsMono Nerd Font"
                elide: Text.ElideMiddle
            }
        }

        states: [
            State {
                name: "selected"
                when: appRoot.isSelected

                PropertyChanges {
                    prefixRec {
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
