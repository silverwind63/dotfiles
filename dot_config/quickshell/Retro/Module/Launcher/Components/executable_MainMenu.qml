pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.Services

ListView {
    id: root
    width: appNameWidth + prefixRecSpace
    height: appToShow * appHeight

    required property string searchKeyword
    property string curretApp
    property int lastIndex: 0
    property int maxString: 30
    property int textWidth: 12
    property int prefixRecSpace: 8
    property int appNameWidth: maxString * textWidth
    property int appToShow: 8
    property int appHeight: 27
    spacing: 5

    model: {
        if (GlobalStates.appsLauncherOpen) {
            return appsDelegateModel;
        } else if (GlobalStates.clipboardOpen) {
            return clipboardDelegateModel;
        } else if (GlobalStates.powerMenuOpen) {
            return powerDelegateModel;
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
    PowerDelegateModel {
        id: powerDelegateModel
        searchKeyword: root.searchKeyword
    }
}
