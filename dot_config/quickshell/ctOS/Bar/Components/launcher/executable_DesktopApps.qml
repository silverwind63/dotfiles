import Quickshell
import QtQuick
import "../../Scripts/fuzzysort.js" as Fuzzy
import "../CornerFrame.qml"

ListView {
    id: main
    width: parent.width
    height: parent.height

    required property AppNameField search

    model: Fuzzy.go(search.text, DesktopEntries.applications.values, {
        all: true,
        keys: ["name", "genericName"]
    }).map(a => a.obj)
    delegate: Item {
        id: appRoot
        required property var modelData
        property bool isSelected: ListView.isCurrentItem

        height: appName.height
        width: parent.width

        CornerFrame {
            id: appFrame
            height: appName.height
            width: parent.width
            frameOpacity: 0

            Text {
                id: appName
                text: appRoot.modelData.name
                color: "white"
                font.pointSize: 15
                font.family: "JetBrainsMono Nerd Font"
            }
        }
        states: [
            State {
                name: "selected"
                when: appRoot.isSelected

                PropertyChanges {
                    target: appFrame
                    frameOpacity: 1
                }
            }
        ]
    }
}

/*
Item {

    Component {
        id: appObject
        Item {
            id: appRoot
            required property var modelData
            height: appName.height
            width: parent.width

            Rectangle {
                height: appName.height
                width: parent.width
                color: "transparent"
                border {
                    color: "white"
                    width: 2
                }
                anchors.left: appName.left
                anchors.bottom: appName.bottom
                anchors.top: appName.top
            }
            Text {
                id: appName
                text: appRoot.modelData.name
                color: "white"
                font.pointSize: 15
                font.family: "JetBrainsMono Nerd Font"
            }
        }
    }
    /*
    Component {
        id: appObject
        Item {
            id: appRoot
            required property var modelData
            height: appName.height
            width: parent.width

            CornerFrame {
                height: appName.height
                width: parent.width
                Text {
                    id: appName
                    text: appRoot.modelData.name
                    color: "white"
                    font.pointSize: 15
                    font.family: "JetBrainsMono Nerd Font"
                }
            }
        }
    }
    ListView {
        id: main
        width: parent.width
        height: parent.height
        model: DesktopEntries.applications
        delegate: appObject
    }
}
*/
