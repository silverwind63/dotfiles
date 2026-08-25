pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.Services
import QtQuick.Layouts

Item {
    id: root
    height: 50
    width: mainmenu.width

    ListView {
        id: mainmenu
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: contentWidth
        height: 50
        spacing: 25
        opacity: 0

        Layout.alignment: Qt.AlignCenter
        orientation: ListView.Horizontal
        model: PowerDelegateModel {
            id: powerDelegateModel
        }
        focus: true
        Keys.onUpPressed: {
            mainmenu.decrementCurrentIndex();
        }
        Keys.onDownPressed: {
            mainmenu.incrementCurrentIndex();
        }

        Keys.onEscapePressed: {
            GlobalStates.powerMenuOpen = false;
        }
        Keys.onReturnPressed: mainmenu.currentItem?.run_cmd()

        Behavior on opacity {
            SequentialAnimation {
                PauseAnimation {
                    duration: 300
                }
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }
    Component.onCompleted: {
        console.log("start");
        mainmenu.opacity = 1;
        if (GlobalStates.powerMenuOpen) {
            mainmenu.forceActiveFocus();
        }
    }
}
