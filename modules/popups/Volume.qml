import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Shapes 1.11
import QtQuick.Layouts
import qs.configs
import qs.components
import qs.services

//TODO: add animations to the opening and closing of window (maybe states)
//TODO: make animation occur after lazyloader has fully loaded it in
//TODO: make animation for closing occur after clicking out of volume area or when clicking volume icon again, then unload the lazyloader

PanelWindow {
    id: root
    anchors {
        top: true
        right: true
    }
    implicitHeight: controlWrapper.implicitHeight + 10
    implicitWidth: volControl.implicitWidth + 30
    margins.top: -10
    margins.right: 115
    color: "transparent"
    
    Shape {
        id: background
        preferredRendererType: Shape.CurveRenderer
        property real disX: 10
        property real disY: 10
        property real radX: 10
        property real radY: 10
        y: -root.implicitHeight

        ShapePath {
            fillColor: Colors.tertiary
            strokeWidth: 0
            startX: 0
            startY: 0

            PathArc  { relativeX: background.disX; relativeY: background.disY; radiusX: background.radX; radiusY: background.radY }
            PathLine { relativeX: 0; y: root.implicitHeight - background.disY}
            PathArc  { relativeX: background.disX; relativeY: background.disY; radiusX: background.radX; radiusY: background.radY; direction: PathArc.Counterclockwise}
            PathLine { relativeX: volControl.implicitWidth - background.disX; relativeY: 0}
            PathArc  { relativeX: background.disX; relativeY: -background.disY; radiusX: background.radX; radiusY: background.radY; direction: PathArc.Counterclockwise}
            PathLine { relativeX: 0; y: background.disY }
            PathArc  { relativeX: background.disX; relativeY: -background.disY; radiusX: background.radX; radiusY: background.radY}
            PathLine { x: 0; y: 0}
        }

        ColumnLayout {
            id: controlWrapper
            anchors.centerIn: parent
            visible: true
            spacing: 3
            Slider {
                id: volControl
                value: AudioService.volume
                Layout.alignment: Qt.AlignHCenter
                orientation: Qt.Vertical
                onMoved: AudioService.setVolume(value)
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
                        y: volControl.handle.y
                        implicitHeight: parent.height - y
                        color: Colors.secondary
                        radius: parent.radius
                    }
                }

                handle: Rectangle {
                    implicitHeight: 20
                    implicitWidth: 20
                    radius: 15
                    x: volControl.availableWidth / 2 - implicitWidth / 2 
                    y: volControl.visualPosition * (volControl.availableHeight - height)
                }
            }

            Text {
                id: volumeNum
                text: Math.trunc(AudioService.volume * 100)
                Layout.alignment: Qt.AlignHCenter
                width: Math.ceil(contentWidth)
                font.pointSize: 10
            }
        }
        NumberAnimation on y {to: 0; duration: 200; running: true}
    }
}