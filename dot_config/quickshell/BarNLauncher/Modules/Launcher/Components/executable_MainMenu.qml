pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../../Scripts/fuzzysort.js" as Fuzzy
import qs.Components
import qs.Common
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

    model: GlobalStates.appsLauncherOpen ? appsDelegateModel : (GlobalStates.clipboardOpen ? clipboardDelegateModel : null)

    AppsDelegateModel {
        id: appsDelegateModel
        searchKeyword: root.searchKeyword
    }
    ClipboardDelegateModel {
        id: clipboardDelegateModel
        searchKeyword: root.searchKeyword
    }
}
