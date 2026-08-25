pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../../scripts/fuzzysort.js" as Fuzzy
import qs.Services

DelegateModel {
    id: root

    required property string searchKeyword

    model: Fuzzy.go(searchKeyword, DesktopEntries.applications.values, {
        all: true,
        keys: ["name", "genericName"]
    }).map(a => a.obj)

    delegate: Rectangle {
        id: appRoot
        required property DesktopEntry modelData
        required property int index
        property bool isSelected: ListView.isCurrentItem

        height: appName.height * 2
        width: parent.width
        function executeApp(): void {
            Quickshell.execDetached({
                command: modelData.runInTerminal ? ["kitty", modelData.command] : modelData.command,
                workingDirectory: modelData.workingDirectory
            });
            GlobalStates.appsLauncherOpen = false;
        }
        color: "#1e2326"
        radius: 15

        Text {
            id: appName
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 12
            anchors.top: parent.top
            anchors.topMargin: height / 2
            text: appRoot.modelData.name

            color: "#d3c6aa"
            font.pointSize: 12
            font.family: "JetBrainsMono Nerd Font"
            elide: Text.ElideMiddle
        }

        states: [
            State {
                name: "selected"
                when: appRoot.isSelected
                PropertyChanges {
                    appRoot {
                        color: "#A7c080"
                    }
                    appName {
                        color: "#1e2326"
                    }
                }
            }
        ]

        Behavior on color {
            ColorAnimation {
                duration: appRoot.index === 0 ? 0 : 150
            }
        }
    }
}
