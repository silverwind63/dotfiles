import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.Modules.Launcher.Components
import qs.Components
import qs.Services

WrapperRectangle {
    id: root
    readonly property int transparentMargin: 100 // The transparent part that is outside the main Launcher menu
    implicitWidth: menuBackground.width + 2 * root.transparentMargin
    implicitHeight: menuBackground.height + 2 * root.transparentMargin

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
        implicitWidth: testBack.width + 20
        implicitHeight: testBack.height + 20
        Row {
            id: downBackground
            //opacity: 0
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
                property var current: appEntries.currentIndex

                background.width: 0//appEntries.width

                Keys.onUpPressed: {
                    appEntries.decrementCurrentIndex();
                }
                Keys.onDownPressed: {
                    appEntries.incrementCurrentIndex();
                }
                Keys.onReturnPressed: {
                    upFinishAnimation.start();
                    middleFinishAnimation.start();
                    downFinishAnimation.start();
                    menuFinishAnimation.start();
                    appEntries.currentItem?.executeApp();
                }
                Keys.onEscapePressed: {
                    upFinishAnimation.start();
                    middleFinishAnimation.start();
                    downFinishAnimation.start();
                    menuFinishAnimation.start();
                }
            }

            DesktopApps {
                id: appEntries
                searchKeyword: appNameField.text
                Layout.alignment: Qt.AlignCenter
                anchors.top: appNameField.bottom
                anchors.topMargin: 20
            }
        }
    }

    ParallelAnimation {}

    SequentialAnimation {
        id: upStartAnimation
        NumberAnimation {
            target: upHover
            property: "width"
            duration: 300
            to: upBackgroud.width
        }
        PauseAnimation {
            duration: 200
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
            duration: 300
            to: 0
        }
    }

    SequentialAnimation {
        id: middleStartAnimation
        NumberAnimation {
            target: middlHover
            property: "width"
            duration: 300
            to: middleBackgroud.width
        }
        PauseAnimation {
            duration: 200
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
            duration: 300
            to: 0
        }
    }

    SequentialAnimation {
        id: downStartAnimation
        NumberAnimation {
            target: downHover
            property: "width"
            duration: 300
            to: downBackground.width
        }
        PauseAnimation {
            duration: 200
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
            duration: 300
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
            duration: 300
            to: upBackgroud.width
        }
        PauseAnimation {
            duration: 200
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
            duration: 300
            to: 0
        }
        ScriptAction {
            script: GlobalStates.appsLauncherOpen = false
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
            duration: 300
            to: middleBackgroud.width
        }
        PauseAnimation {
            duration: 200
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
            duration: 300
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
            duration: 300
            to: downBackground.width
        }
        PauseAnimation {
            duration: 200
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
            duration: 300
            to: 0
        }
    }

    SequentialAnimation {
        id: menuStartAnimation
        PauseAnimation {
            duration: 600
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
