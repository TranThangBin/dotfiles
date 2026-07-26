import "../config.qml" as Config

import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    WlrLayershell.layer: WlrLayer.Bottom

    anchors {
        bottom: true
        left: true
        right: true
        top: true
    }

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: Qt.resolvedUrl(Config.wallpaperPath)
    }
}
