pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../../scripts/fuzzysort.js" as Fuzzy
import qs.Services

DelegateModel {
    id: root

    required property string searchKeyword
    property int width

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
            GlobalStates.appsLauncherOpen = false;
        }

        Item {
            width: parent.width
            Rectangle {
                id: backRec
                width: parent.width
                height: appName.height
                color: "#f9f5d7"
                Canvas {
                    id: star
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.rightMargin: 2
                    width: parent.height - 4
                    height: parent.height - 4
                    opacity: 0

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.fillStyle = "#83a598";
                        ctx.fillRect(0, 0, width, height);

                        const starOutCol = "#ebdbb2";
                        const radius = height / 2;

                        ctx.beginPath();
                        ctx.lineWidth = radius;
                        // top left arc
                        ctx.arc(0, 0, radius / 2, Math.PI / 2, 0, true);
                        ctx.strokeStyle = starOutCol;
                        ctx.stroke();

                        ctx.beginPath();
                        ctx.lineWidth = radius;
                        // top right arc
                        ctx.arc(width, 0, radius / 2, Math.PI / 2, Math.PI, false);
                        ctx.strokeStyle = starOutCol;
                        ctx.stroke();

                        ctx.beginPath();
                        ctx.lineWidth = radius;
                        // bottom left arc
                        ctx.arc(0, height, radius / 2, -Math.PI / 2, 0, false);
                        ctx.strokeStyle = starOutCol;
                        ctx.stroke();

                        ctx.beginPath();
                        ctx.lineWidth = radius;
                        // bottom right arc
                        ctx.arc(width, height, radius / 2, -Math.PI / 2, Math.PI, true);
                        ctx.stroke();
                    }
                }
            }

            Text {
                id: appName
                width: parent.width
                text: appRoot.modelData.name

                color: "#282828"
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
                    backRec {
                        color: "#ebdbb2"
                    }
                    appName {
                        color: "#282828"
                    }
                }
            }
        ]
    }
}
