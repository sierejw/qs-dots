import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root
    anchors.left: true
    anchors.right: true
    anchors.top: true
    anchors.bottom: true
    WlrLayershell.layer: WlrLayer.Bottom
    visible: true
    color: "transparent"

    Rectangle {
        id: menuroot
        implicitHeight: 60
        implicitWidth: implicitHeight
        color: "red"

        Text {
            text: "test"
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {root.visible = !root.visible}
    }
}