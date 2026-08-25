import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.Modules.Bar
import qs.Modules.Launcher
import qs.Services

PanelWindow {
    id: root

    focusable: false
    implicitHeight: Screen.height

    implicitWidth: launcher.implicitWidth
    exclusiveZone: bar.height
    color: "transparent"

    WlrLayershell.keyboardFocus: {
        if (launcher.active) {
            WlrKeyboardFocus.Exclusive;
        } else {
            WlrKeyboardFocus.None;
        }
    }

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

    Loader {
        id: launcher
        anchors.horizontalCenter: parent.horizontalCenter
        active: GlobalStates.clipboardOpen || GlobalStates.appsLauncherOpen
        sourceComponent: Launcher {
            id: appLauncher
        }
        y: (Screen.height - height) / 2
    }

    Bar {
        id: bar
    }

    /*
    Loader {
        id: bar
        active: true
        sourceComponent: Bar {}
    }
    */
}
