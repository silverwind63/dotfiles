pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Singleton {
    id: root

    property bool appsLauncherOpen: false
    property bool clipboardOpen: false
    property bool controlCenterOpen: false
    property bool testOverviewOpen: false
    property bool wallpaperSelectorOpen: false
}
