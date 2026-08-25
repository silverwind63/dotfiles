pragma Singleton

import Quickshell
import Quickshell.Io
import qs.Services

Singleton {
    id: root

    property list<string> list: []

    Process {
        command: ["cliphist", "list"]
        running: GlobalStates.clipboardOpen
        stdout: StdioCollector {
            onStreamFinished: {
                root.list = text.trim().split('\n');
            }
        }
    }
}
