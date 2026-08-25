pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../../scripts/fuzzysort.js" as Fuzzy
import qs.Services

DelegateModel {
    id: root

    required property string searchKeyword
    property int width
    property list<string> powerOptions: ["reboot", "poweroff", "suspend"]

    model: Fuzzy.go(searchKeyword, root.powerOptions, {
        all: true
    }).map(a => a.target)

    delegate: Item {
        id: powerRoot
        required property string modelData
        property bool isSelected: ListView.isCurrentItem

        height: powerString.height
        width: parent.width
        function run_cmd(): void {
            Quickshell.execDetached(["sh", "-c", `systemctl "${modelData}"`]);
            GlobalStates.powerMenuOpen = false;
        }

        Item {
            width: parent.width
            Rectangle {
                id: backRec
                width: parent.width
                height: powerString.height
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
                id: powerString
                width: parent.width
                text: powerRoot.modelData.replace(/^\d+\s+/, '').trim()

                color: "#282828"
                font.pointSize: 15
                font.family: "JetBrainsMono Nerd Font"
                elide: Text.ElideMiddle
            }
        }

        states: [
            State {
                name: "selected"
                when: powerRoot.isSelected

                PropertyChanges {
                    backRec {
                        color: "#ebdbb2"
                    }
                    powerString {
                        color: "#282828"
                    }
                    star {
                        opacity: 1
                    }
                }
            }
        ]
    }
}
