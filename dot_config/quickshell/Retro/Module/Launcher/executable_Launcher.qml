import Quickshell.Widgets
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Services
import qs.Module.Launcher.Components

Rectangle {
    id: root
    Rectangle {
        id: background
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        property int sidePadding: 60
        height: content.height + 2 * sidePadding
        width: content.width + 2 * sidePadding
        color: "#f9f5d7"
        border.color: "#282828"
        border.width: 3

        ColumnLayout {
            id: content

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 300
            spacing: 20
            AppNameField {
                id: appField
                inputWidth: parent.width

                Keys.onUpPressed: {
                    mainmenu.decrementCurrentIndex();
                }
                Keys.onDownPressed: {
                    mainmenu.incrementCurrentIndex();
                }
                Keys.onReturnPressed: {
                    if (GlobalStates.appsLauncherOpen) {
                        return mainmenu.currentItem?.executeApp();
                    } else if (GlobalStates.clipboardOpen) {
                        return mainmenu.currentItem?.decodeAndCopy();
                    } else if (GlobalStates.powerMenuOpen) {
                        return mainmenu.currentItem?.run_cmd();
                    }
                }

                Keys.onEscapePressed: {
                    GlobalStates.clipboardOpen = false;
                    GlobalStates.appsLauncherOpen = false;
                    GlobalStates.powerMenuOpen = false;
                }
            }
            MainMenu {
                id: mainmenu
                width: parent.width
                searchKeyword: appField.text
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
