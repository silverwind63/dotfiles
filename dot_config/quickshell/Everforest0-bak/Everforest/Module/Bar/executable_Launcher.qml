import Quickshell.Widgets
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Services
import qs.Module.Bar.Launcher

PanelWindow {
    id: root
    focusable: true
    implicitHeight: 350
    implicitWidth: 400
    color: "transparent"
    exclusionMode: ExclusionMode.Normal
    anchors.bottom: true
    Rectangle {
        id: background
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        height: content.height + 4 * content.spacing
        width: 400
        color: "#1e2326"
        radius: 10
        Behavior on height {
            NumberAnimation {
                duration: 150
            }
        }
    }

    Column {
        id: content

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: background.verticalCenter
        width: 400
        height: mainmenu.contentHeight + appField.height + 3 * spacing > 300 ? 300 : mainmenu.contentHeight + appField.height + 2 * spacing
        spacing: 10
        Rectangle {
            width: parent.width
            height: 5
            color: "transparent"
        }

        AppNameField {
            id: appField
            inputWidth: parent.width * (7 / 8)
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 16

            Keys.onUpPressed: {
                mainmenu.decrementCurrentIndex();
            }
            Keys.onDownPressed: {
                mainmenu.incrementCurrentIndex();
            }
            Keys.onReturnPressed: launchAnim.start()

            Keys.onEscapePressed: {
                exitAnim.start();
            }
        }
        LauncherMenu {
            id: mainmenu
            width: parent.width * (7 / 8)
            height: parent.height - appField.height - 5 * content.spacing
            anchors.horizontalCenter: parent.horizontalCenter
            searchKeyword: appField.text
            Layout.alignment: Qt.AlignCenter
            z: appField.z - 1
        }
    }
    SequentialAnimation {
        id: exitAnim
        NumberAnimation {
            target: content
            property: "opacity"
            to: 0
            duration: 10
        }
        NumberAnimation {
            target: background
            property: "height"
            to: 0
            duration: 50
        }
        ScriptAction {
            script: {
                GlobalStates.clipboardOpen = false;
                GlobalStates.appsLauncherOpen = false;
            }
        }
    }

    SequentialAnimation {
        id: launchAnim
        NumberAnimation {
            target: content
            property: "opacity"
            to: 0
            duration: 10
        }
        NumberAnimation {
            target: background
            property: "height"
            to: 0
            duration: 50
        }
        ScriptAction {
            script: {
                if (GlobalStates.appsLauncherOpen) {
                    mainmenu.currentItem?.executeApp();
                } else if (GlobalStates.clipboardOpen) {
                    mainmenu.currentItem?.decodeAndCopy();
                }
            }
        }
    }

    SequentialAnimation {
        id: initAnim
        NumberAnimation {
            targets: background
            property: "height"
            from: 0
            to: content.height + 4 * content.spacing
            duration: 50
        }
    }
    Component.onDestruction: {
        background.height = 0;
    }

    Component.onCompleted: {
        initAnim.start();
    }
}
