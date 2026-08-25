pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import Quickshell.Hyprland
import qs.Services
import qs.Module.Workspace
import qs.Module.Bar
import qs.Module.Launcher

Scope {
    Socket {
        // Create and connect a Socket to the hyprland event socket.
        // https://wiki.hyprland.org/IPC/
        path: `/run/user/1000/hypr/${Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")}/.socket2.sock`
        connected: true

        parser: SplitParser {
            // Regex that will return the newly focused monitor when it changes.
            property var regex: new RegExp("focusedmon>>(.+),.*")

            // Sent for every line read from the socket
            onRead: msg => {
                const match = regex.exec(msg);

                if (match != null) {
                    // Filter out the right screen from the list and update the panel.
                    // match[1] will always be the monitor name captured by the regex.
                    panel.screen = Quickshell.screens.filter(screen => screen.name == match[1])[0];
                }
            }
        }
    }

    PanelWindow {
        id: panel
        required property var modelData

        anchors {
            bottom: false
            top: false
            left: false
            right: false
        }
        implicitHeight: Screen.height
        implicitWidth: Screen.width

        color: "transparent"

        WlrLayershell.layer: WlrLayer.Overlay

        mask: Region {}

        Variants {
            id: regions
            //makes regions by looking at childrenitems
            model: panel.contentItem.children

            delegate: Region {
                required property Item modelData
                item: modelData
            }
        }

        WlrLayershell.keyboardFocus: {
            if (launcher.active) {
                WlrKeyboardFocus.Exclusive;
            } else {
                WlrKeyboardFocus.None;
            }
        }

        Loader {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            active: GlobalStates.workspaceIndicator
            sourceComponent: Workspace {
                id: workspace
            }
        }

        Loader {
            id: launcher
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.implicitWidth
            height: parent.implicitHeight
            active: GlobalStates.clipboardOpen || GlobalStates.appsLauncherOpen || GlobalStates.powerMenuOpen
            sourceComponent: Launcher {}
        }

        Bar {}
    }

    GlobalShortcut {
        name: "WorkspaceIndicator"
        description: "Toggle the workspace indicator"
        onPressed: GlobalStates.workspaceIndicator = true
        onReleased: GlobalStates.workspaceIndicator = false
    }

    GlobalShortcut {
        name: "Clipboard"
        description: "Toggle clipboard's visiblity"
        onPressed: {
            GlobalStates.workspaceIndicator = false;
            GlobalStates.clipboardOpen = !GlobalStates.clipboardOpen;
        }
    }

    GlobalShortcut {
        name: "Launcher"
        description: "Toggle launcher's visiblity"
        onPressed: {
            GlobalStates.workspaceIndicator = false;
            GlobalStates.appsLauncherOpen = true;
        }
    }

    GlobalShortcut {
        name: "PowerMenu"
        description: "Toggle PowerMenu's visiblity"
        onPressed: {
            GlobalStates.workspaceIndicator = false;
            GlobalStates.powerMenuOpen = true;
        }
    }
}
