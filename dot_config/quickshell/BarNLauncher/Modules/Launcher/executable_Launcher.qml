import Quickshell.Widgets
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Modules.Launcher.Components
import qs.Services

PanelWindow {
    id: root
    readonly property int transparentMargin: 100 // The transparent part that is outside the main Launcher menu
    implicitWidth: menuBackground.width + 2 * root.transparentMargin
    implicitHeight: menuBackground.height + 2 * root.transparentMargin
    focusable: true

    mask: Region {}

    Variants {
        id: regions
        //makes regions by looking at childrenitems

        model: root.contentItem.children

        delegate: Region {
            required property Item modelData
            item: modelData
        }
    }

    /*
    implicitWidth: menuBackground.width + 2 * transparentMargin
    implicitHeight: menuBackground.height + 2 * transparentMargin
    */
    component SlashImage: Image {
        id: slashBack
        source: "../../Resources/slash.svg"
        antialiasing: false
        smooth: false
    }

    color: "transparent"

    Rectangle {
        id: mainFrame
        color: "transparent"
        Row {
            id: downBackground
            opacity: 0
            anchors.left: menuBackground.left
            anchors.bottom: menuBackground.bottom
            spacing: 0
            Repeater {
                model: 3
                SlashImage {
                    width: 100
                }
            }
        }

        Row {
            id: middleBackgroud

            opacity: 0
            anchors.right: menuBackground.right
            anchors.bottom: downBackground.top
            spacing: 0
            Repeater {
                model: 4
                SlashImage {
                    width: 100
                }
            }
        }

        Row {
            id: upBackgroud

            opacity: 0
            anchors.left: root.left
            anchors.bottom: middleBackgroud.top
            spacing: 0
            Repeater {
                model: 4
                SlashImage {
                    width: 100
                }
            }
        }
        Rectangle {
            id: upHover
            color: "black"
            width: 0
            height: upBackgroud.height
            anchors.left: upBackgroud.left
            anchors.top: upBackgroud.top
        }
        Rectangle {
            id: middlHover
            color: "black"
            width: 0
            height: middleBackgroud.height
            anchors.left: middleBackgroud.left
            anchors.top: middleBackgroud.top
        }
        Rectangle {
            id: downHover
            color: "black"
            width: 0
            height: downBackground.height
            anchors.left: downBackground.left
            anchors.top: downBackground.top
        }

        Rectangle {
            id: menuBackground
            color: "transparent"
            width: main.width + root.transparentMargin
            height: main.height + root.transparentMargin
            anchors.verticalCenter: main.verticalCenter
            anchors.horizontalCenter: main.horizontalCenter
        }
        ColumnLayout {
            id: main
            spacing: 20

            opacity: 0
            anchors.top: parent.top
            anchors.topMargin: root.transparentMargin * 1.5
            anchors.left: parent.left
            anchors.leftMargin: root.transparentMargin * 1.5

            AppNameField {
                id: appNameField

                Layout.preferredHeight: 3.10 * appNameField.rem

                color: "white"
                property var current: mainmenu.currentIndex

                background.width: 0//appEntries.width

                Keys.onUpPressed: {
                    mainmenu.decrementCurrentIndex();
                }
                Keys.onDownPressed: {
                    mainmenu.incrementCurrentIndex();
                }
                Keys.onReturnPressed: {
                    upFinishAnimation.start();
                    if (mainmenu.contentHeight < (1 / 5) * menuBackground.height) {
                        middleFinishAnimation.resume();
                    } else {
                        middleFinishAnimation.start();
                    }
                    if (mainmenu.contentHeight < (1 / 3) * menuBackground.height) {
                        downFinishAnimation.resume();
                    } else {
                        downFinishAnimation.start();
                    }
                    menuFinishAnimation.start();
                    GlobalStates.appsLauncherOpen ? mainmenu.currentItem?.executeApp() : (GlobalStates.clipboardOpen ? mainmenu.currentItem?.decodeAndCopy() : null);
                }
                Keys.onEscapePressed: {
                    upFinishAnimation.start();
                    if (mainmenu.contentHeight < (1 / 5) * menuBackground.height) {
                        middleFinishAnimation.resume();
                    } else {
                        middleFinishAnimation.start();
                    }
                    if (mainmenu.contentHeight < (1 / 3) * menuBackground.height) {
                        downFinishAnimation.resume();
                    } else {
                        downFinishAnimation.start();
                    }
                    menuFinishAnimation.start();
                }
            }

            MainMenu {
                id: mainmenu
                searchKeyword: appNameField.text
                property var lastContentHeight: mainmenu.contentHeight
                Layout.alignment: Qt.AlignCenter
                anchors.top: appNameField.bottom
                anchors.topMargin: 20
                onContentHeightChanged: {
                    if (mainmenu.contentHeight < (1 / 3) * menuBackground.height && mainmenu.lastContentHeight > (1 / 3) * menuBackground.height) {
                        downFinishAnimation.start();
                    } else if (mainmenu.contentHeight > (1 / 3) * menuBackground.height && mainmenu.lastContentHeight < (1 / 3) * menuBackground.height) {
                        downStartAnimation.start();
                    }
                    if (mainmenu.contentHeight < (1 / 5) * menuBackground.height && mainmenu.lastContentHeight > (1 / 5) * menuBackground.height) {
                        middleFinishAnimation.start();
                    } else if (mainmenu.contentHeight > (1 / 5) * menuBackground.height && mainmenu.lastContentHeight < (1 / 5) * menuBackground.height) {
                        middleStartAnimation.start();
                    }

                    mainmenu.lastContentHeight = mainmenu.contentHeight;
                }
            }
        }
    }

    ParallelAnimation {}

    SequentialAnimation {
        id: upStartAnimation
        NumberAnimation {
            target: upHover
            property: "width"
            duration: 200
            to: upBackgroud.width
        }
        PauseAnimation {
            duration: 100
        }
        ScriptAction {
            script: upHover.anchors.left = undefined
        }
        ScriptAction {
            script: upHover.anchors.right = upBackgroud.right
        }
        ScriptAction {
            script: upBackgroud.opacity = 1
        }

        NumberAnimation {
            target: upHover
            property: "width"
            duration: 200
            to: 0
        }
    }

    SequentialAnimation {
        id: middleStartAnimation
        ScriptAction {
            script: middlHover.anchors.right = undefined
        }
        ScriptAction {
            script: middlHover.anchors.left = middleBackgroud.left
        }
        NumberAnimation {
            target: middlHover
            property: "width"
            duration: 200
            to: middleBackgroud.width
        }
        PauseAnimation {
            duration: 100
        }
        ScriptAction {
            script: middlHover.anchors.left = undefined
        }
        ScriptAction {
            script: middlHover.anchors.right = middleBackgroud.right
        }
        ScriptAction {
            script: middleBackgroud.opacity = 1
        }

        NumberAnimation {
            target: middlHover
            property: "width"
            duration: 200
            to: 0
        }
    }

    SequentialAnimation {
        id: downStartAnimation
        ScriptAction {
            script: downHover.anchors.right = undefined
        }
        ScriptAction {
            script: downHover.anchors.left = downBackground.left
        }
        NumberAnimation {
            target: downHover
            property: "width"
            duration: 200
            to: downBackground.width
        }
        PauseAnimation {
            duration: 100
        }
        ScriptAction {
            script: downHover.anchors.left = undefined
        }
        ScriptAction {
            script: downHover.anchors.right = downBackground.right
        }
        ScriptAction {
            script: downBackground.opacity = 1
        }

        NumberAnimation {
            target: downHover
            property: "width"
            duration: 200
            to: 0
        }
    }

    SequentialAnimation {
        id: upFinishAnimation
        ScriptAction {
            script: upHover.anchors.right = undefined
        }
        ScriptAction {
            script: upHover.anchors.left = upBackgroud.left
        }
        NumberAnimation {
            target: upHover
            property: "width"
            duration: 200
            to: upBackgroud.width
        }
        PauseAnimation {
            duration: 100
        }
        ScriptAction {
            script: upHover.anchors.left = undefined
        }
        ScriptAction {
            script: upHover.anchors.right = upBackgroud.right
        }
        ScriptAction {
            script: upBackgroud.opacity = 0
        }

        NumberAnimation {
            target: upHover
            property: "width"
            duration: 200
            to: 0
        }
        ScriptAction {
            script: GlobalStates.appsLauncherOpen = false
        }
        ScriptAction {
            script: GlobalStates.clipboardOpen = false
        }
    }

    SequentialAnimation {
        id: middleFinishAnimation
        ScriptAction {
            script: middlHover.anchors.right = undefined
        }
        ScriptAction {
            script: middlHover.anchors.left = middleBackgroud.left
        }
        NumberAnimation {
            target: middlHover
            property: "width"
            duration: 200
            to: middleBackgroud.width
        }
        PauseAnimation {
            duration: 100
        }
        ScriptAction {
            script: middlHover.anchors.left = undefined
        }
        ScriptAction {
            script: middlHover.anchors.right = middleBackgroud.right
        }
        ScriptAction {
            script: middleBackgroud.opacity = 0
        }

        NumberAnimation {
            target: middlHover
            property: "width"
            duration: 200
            to: 0
        }
    }
    SequentialAnimation {
        id: downFinishAnimation
        ScriptAction {
            script: downHover.anchors.right = undefined
        }
        ScriptAction {
            script: downHover.anchors.left = downBackground.left
        }
        NumberAnimation {
            target: downHover
            property: "width"
            duration: 200
            to: downBackground.width
        }
        PauseAnimation {
            duration: 100
        }
        ScriptAction {
            script: downHover.anchors.left = undefined
        }
        ScriptAction {
            script: downHover.anchors.right = downBackground.right
        }
        ScriptAction {
            script: downBackground.opacity = 0
        }

        NumberAnimation {
            target: downHover
            property: "width"
            duration: 200
            to: 0
        }
    }

    SequentialAnimation {
        id: menuStartAnimation
        PauseAnimation {
            duration: 300
        }
        NumberAnimation {
            target: main
            property: "opacity"
            duration: 200
            to: 1
        }
    }

    SequentialAnimation {
        id: menuFinishAnimation
        PauseAnimation {
            duration: 100
        }
        NumberAnimation {
            target: main
            property: "opacity"
            duration: 200
            to: 0
        }
    }

    Component.onCompleted: {
        upStartAnimation.start();
        middleStartAnimation.start();
        downStartAnimation.start();
        menuStartAnimation.start();
    }
}
