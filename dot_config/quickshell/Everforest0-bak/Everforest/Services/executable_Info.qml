pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int cpuPer: 0
    property real memUsage: 0
    property string date
    property string time
    property string ssid
    property int strength

    Process {
        id: cpuProc
        command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'"]
        //command: ["bash", "../Scripts/getCPU.sh"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: root.cpuPer = this.text
        }
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free -m | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                let parts = data.trim().split(/\s+/);
                let total = parseInt(parts[1]) || 1;
                let used = parseInt(parts[2]) || 0;
                // root.percent = used / total;
                root.memUsage = Math.round((used / 1024) * 10) / 10;
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: getssid
        command: ["bash", "-c", "nmcli -t -f active,ssid,signal,security dev wifi | grep '^yes'"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: {
                const match = this.text.match(/yes:(.+):(\d+)/);
                root.ssid = match ? match[1] : "disconnected";
            }
        }
    }

    Process {
        id: timeProc
        command: ["date", "+%Y/%m/%d%H:%M:%S"]
        running: true

        stdout: StdioCollector {
            // update the property instead of the clock directly
            onStreamFinished: {
                root.date = this.text.slice(0, 10);
                root.time = this.text.slice(10);
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            timeProc.running = true;
        }
    }
    Timer {
        interval: 2500
        running: true
        repeat: true
        onTriggered: {
            memProc.running = true;
            cpuProc.running = true;
            getssid.running = true;
        }
    }
}
