import Quickshell
import Quickshell.Hyprland
import qs.Services

Scope {
    GlobalShortcut {
        name: "Clipboard"
        description: "Toggle clipboard's visiblity"
        onPressed: GlobalStates.clipboardOpen = true
    }

    GlobalShortcut {
        name: "Launcher"
        description: "Toggle launcher's visiblity"
        onPressed: GlobalStates.appsLauncherOpen = true
    }
}
