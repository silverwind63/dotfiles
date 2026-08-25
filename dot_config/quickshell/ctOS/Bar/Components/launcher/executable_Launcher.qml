import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Wayland
import QtQuick.Layouts
import "../scripts/fuzzysort.js" as Fuzzy
import "../scripts/script.js" as MyScript

PanelWindow {
    id: root

    property var modelData
    property var monitorWidth
    property var monitorHeight

    anchors {
        top: true
        right: true
    }

    margins.right: (1920 - width) / 2

    implicitWidth: 300
    implicitHeight: 500

    color: "black"

    focusable: true

    // Use the wlroots specific layer property to ensure it displays over
    // fullscreen windows.
    WlrLayershell.layer: WlrLayer.Overlay

    AppNameField {
        id: appNameField
        width: parent.width
        anchors.top: parent.top
        Layout.preferredHeight: 3.10 * appNameField.rem
        color: "white"
        property var current: appEntries.currentIndex

        Component.onCompleted: {
            appNameField.forceActiveFocus();
        }
        Keys.onUpPressed: {
            appEntries.decrementCurrentIndex();
        }
        Keys.onDownPressed: {
            appEntries.incrementCurrentIndex();
        }
        Keys.onReturnPressed: {
            const list = appEntries.model;
            if (!notSearching) {
                console.log(list);
                if (list.length > 0) {
                    list[current].execute();
                    root.visible = false;
                }
            }
            if (notSearching) {
                list[current].execute();
                root.visible = false;
            }
        }
    }

    DesktopApps {
        id: appEntries
        search: appNameField
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: appNameField.bottom
        /*
        function launch(): void {
            if (currentItem && currentItem.modelData) {
                currentItem.modelData.execute();
                root.shouldShow = false;
            }
        }
        */
    }
}
