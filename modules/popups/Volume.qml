import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Shapes 1.11
import QtQuick.Layouts
import Quickshell.Wayland
import qs.components
import qs.services

LazyLoader{
    id: root
    active: false
    property bool open: false

    PanelWindow {
        id: volWin

        WlrLayershell.namespace: "popup"

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
            y: root.open ? 0 : -volWin.implicitHeight

            ShapePath {
                fillColor: Colors.tertiary
                strokeWidth: 0
                startX: 0
                startY: 0

                PathArc  { relativeX: background.disX; relativeY: background.disY; radiusX: background.radX; radiusY: background.radY }
                PathLine { relativeX: 0; y: volWin.implicitHeight - background.disY}
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

            Behavior on y {
                NumberAnimation { 
                    duration: 200
                    onRunningChanged: {
                        if (background.y == -volWin.implicitHeight && root.open == false)
                            root.active = false
                    }
                }
            }
        }
    }
}