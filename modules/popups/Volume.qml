import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.components
import qs.services

LazyLoader{
    id: root
    active: false
    property bool open: false

    PanelWindow {
        id: volWin

        anchors {
            top: true
            right: true
        }

        WlrLayershell.namespace: "popup"
        color: "transparent"
        implicitHeight: background.implicitHeight + margin * 2
        implicitWidth: background.implicitWidth + margin * 10
        property real margin: 5
        mask: Region { item: background }

        Rectangle {
            id: background
            color: Colors.tertiary
            implicitHeight: 50
            implicitWidth: 300
            radius: 10
            x: root.open ? volWin.implicitWidth - implicitWidth - volWin.margin : volWin.implicitWidth
            y: margin
            
            RowLayout {
                anchors.centerIn: parent
                spacing: 10
                Item {
                    implicitWidth: 20
                    implicitHeight: 15
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Icon {
                        text: AudioService.getSoundIcon()
                        font.pointSize: 15
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        color: Colors.secondary
                    }
                }
                
                Slider {
                    id: volControl
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    value: AudioService.volume

                    background: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 5
                        width: volControl.availableWidth
                        height: implicitHeight
                        color: Colors.primary
                        anchors.verticalCenter: parent.verticalCenter
                        radius: 5
                        Rectangle {
                            width: volControl.visualPosition * parent.width
                            height: parent.implicitHeight
                            color: Colors.secondary
                            radius: 5

                        }
                    }

                    handle: Rectangle {
                        implicitWidth: 15
                        implicitHeight: 15
                        radius: 10
                        x: volControl.visualPosition * (volControl.availableWidth - width)
                        y: volControl.availableHeight / 2 - height / 2

                    }
                    onMoved: AudioService.setVolume(value)
                }

                Item {
                    implicitHeight: 15
                    implicitWidth: 15
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Text {
                        id: volumeNum
                        text: Math.trunc(AudioService.volume * 100)
                        font.pointSize: 10
                        anchors.centerIn: parent
                        color: Colors.secondary
                    }
                }

                
            }

            Behavior on x {
                NumberAnimation { 
                    duration: 300
                    onRunningChanged: {
                        if (background.x == volWin.implicitWidth && root.open == false)
                            root.active = false
                    }
                    easing: Easing.OutBack
                }
            }
        }

        Component.onCompleted: grab.active = true

        HyprlandFocusGrab {
            id: grab
            windows: [volWin]
            onCleared: {
                root.open = false
                console.log("hi")
            }
        }
    }
}