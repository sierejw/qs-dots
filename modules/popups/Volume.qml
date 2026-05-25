import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Shapes 1.11
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.configs

//TODO: smoothen edges on volume box (fix path arcs)
//TODO: add animations to the opening and closing of window
//TODO: figure where to put in relation to the volume icon (add click area, etc)
//TODO: add dynamic changing of volume icons relative to volume settings
//TODO: potentially abstract out all volume controls to a singleton for other files to reference

Scope {
    id: scope

    property PwNode sink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    PanelWindow {
        id: root
        anchors {
            top: true
            right: true
        }

        implicitHeight: controlWrapper.implicitHeight + 10
        implicitWidth: controlWrapper.implicitWidth + 20
        margins.top: -9
        margins.right: 117
        color: "transparent"
        
        Shape {
            id: background
            //anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer
            ShapePath {
                fillColor: Colors.tertiary
                strokeWidth: 0
                startX: 0
                startY: 0
                PathArc {
                    relativeX: 5
                    relativeY: 5
                    radiusX: 8
                    radiusY: 8
                }
                PathLine { relativeX: 0; y: root.implicitHeight - 10 }
                PathArc  { 
                    relativeX: 5
                    y: root.implicitHeight
                    radiusX: 8
                    radiusY: 8
                    direction: PathArc.Counterclockwise
                }
                PathLine { x: root.implicitWidth - 10; relativeY: 0 }
                PathArc {
                    x: root.implicitWidth - 5
                    relativeY: -10
                    radiusX: 8
                    radiusY: 8
                    direction: PathArc.Counterclockwise
                }
                PathLine { x: root.implicitWidth - 5; y: 5}
                PathArc {
                    relativeX: 5
                    relativeY: -5
                    radiusX: 8
                    radiusY: 8
                }
                PathLine { x: 0; y: 0}
            }
        }
        ColumnLayout {
            id: controlWrapper
            anchors.centerIn: parent
            spacing: 3
            Slider {
                id: control
                value: sink.audio.volume
                //visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                orientation: Qt.Vertical

                onMoved: {
                    sink.audio.muted = false
                    sink.audio.volume = value
                }

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
                    radius: 15
                    x: control.availableWidth / 2 - implicitWidth / 2 
                    y: control.visualPosition * (control.availableHeight - height)
                }
            }

            Text {
                text: Math.trunc(sink.audio.volume * 100)
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 10
            }
        }
    }
}