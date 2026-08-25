pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.Services

ListView {
    id: root
    required property string searchKeyword
    spacing: 5

    model: {
        if (GlobalStates.appsLauncherOpen) {
            return appsDelegateModel;
        } else if (GlobalStates.clipboardOpen) {
            return clipboardDelegateModel;
        }
    }

    AppsDelegateModel {
        id: appsDelegateModel
        searchKeyword: root.searchKeyword
    }
    ClipboardDelegateModel {
        id: clipboardDelegateModel
        searchKeyword: root.searchKeyword
    }
}
