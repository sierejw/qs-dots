import QtQuick
import Quickshell
import QtQuick.Controls
import qs.configs

PanelWindow {
    anchors {
        top: true
        right: true
    }

    implicitHeight: control.implicitHeight + 10
    implicitWidth: control.implicitWidth + 10
    margins.top: -10
    margins.right: 128
    color: "transparent"

    /*Rectangle {
        id: container
        anchors.fill: parent
        //implicitHeight: control.implicitHeight
        //implicitWidth: control.implicitWidth
        color: Colors.tertiary
        radius: 5
    }*/

    Slider {
        id: control
        value: 0
        anchors.centerIn: parent
        orientation: Qt.Vertical

        background: Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: 6
            implicitHeight: 120
            width: implicitWidth
            radius: 2
            color: Colors.primary

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                y: control.handle.y
                implicitHeight: parent.height - y
                color: Colors.secondary
                radius: parent.radius
            }
        }

        handle: Rectangle {
            implicitHeight: 15
            implicitWidth: 15
            radius: 20
            
        }
    }
}
//}
    

    