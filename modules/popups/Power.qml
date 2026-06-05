import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Wayland
import qs.modules.lock
import qs.configs
import qs.components

LazyLoader {
    id: root
    active: false
    property bool open: false
    required property Lock lock

    //Component.onCompleted: console.log(lock == undefined);
    PanelWindow {

        anchors {
            top: true
            right: true
        }

        WlrLayershell.namespace: "power"
        color: "transparent"
        margins.right: 10
        margins.top: 5
        implicitWidth: background.implicitWidth
        implicitHeight: background.implicitHeight

        

        Rectangle {
            id: background
            //anchors.fill: parent
            color: Colors.tertiary
            radius: 10
            y: root.open ? 0 : -implicitHeight

            implicitWidth: layout.implicitWidth + 15
            implicitHeight: layout.implicitHeight + 15

            Behavior on y {
                NumberAnimation {
                    duration: 200;
                    onRunningChanged: {
                        if (background.y == -background.implicitHeight && open == false)
                            root.active = false
                    }
                }
            }

            RowLayout {
                id: layout

                spacing: 12
                anchors.fill: parent
                property real fontSize: 25
                property int bordWidth: 3
                property color bordColor: Colors.primary
                property real bordRadius: 5
                property color cellColor: Colors.tertiary
                property int cellHeight: 60
                property int cellWidth: 60
                property color iconColor: Colors.secondary
                property real textSpacing: 0

                Rectangle {
                    implicitWidth: layout.cellHeight
                    implicitHeight: layout.cellWidth
                    border.color: layout.bordColor
                    border.width: layout.bordWidth
                    radius: layout.bordRadius
                    color: powerArea.containsMouse ?  Qt.lighter(layout.cellColor, 1.5) : layout.cellColor
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: layout.textSpacing
                        Icon {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.rightMargin: 2
                            id: power
                            font.pointSize: layout.fontSize
                            text: "\uf011"
                            color: layout.iconColor
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "Power"
                        }
                    }

                    MouseArea {
                        id: powerArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Quickshell.execDetached(["systemctl", "poweroff"]);
                            root.open = false;
                        }
                    }
                    Layout.leftMargin: 10
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
                
                Rectangle {
                    implicitWidth: layout.cellHeight
                    implicitHeight: layout.cellWidth
                    border.color: layout.bordColor
                    border.width: layout.bordWidth
                    radius: layout.bordRadius
                    color: sleepArea.containsMouse ? Qt.lighter(layout.cellColor, 1.5) : layout.cellColor
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: layout.textSpacing
                        Icon {
                            id: sleep
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pointSize: layout.fontSize
                            text: "\udb81\udcb2"
                            color: layout.iconColor
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "Sleep"
                        }
                    }

                    MouseArea {
                        id: sleepArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Quickshell.execDetached(["systemctl", "suspend"]);
                            root.open = false;
                        }
                    }
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Rectangle {
                    implicitWidth: layout.cellHeight
                    implicitHeight: layout.cellWidth
                    border.color: layout.bordColor
                    border.width: layout.bordWidth
                    radius: layout.bordRadius
                    color: lockArea.containsMouse ? Qt.lighter(layout.cellColor, 1.5) : layout.cellColor
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: layout.textSpacing
                        Icon {
                            id: lock
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pointSize: layout.fontSize
                            text: "\uf023"
                            color: layout.iconColor
                        }
                        
                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "Lock"
                        }
                    }

                    MouseArea {
                        id: lockArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            root.lock.lock.locked = true;
                            root.open = false;
                        }
                    }
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Rectangle {
                    implicitWidth: layout.cellHeight
                    implicitHeight: layout.cellWidth
                    border.color: layout.bordColor
                    border.width: layout.bordWidth
                    radius: layout.bordRadius
                    color: restartArea.containsMouse ? Qt.lighter(layout.cellColor): layout.cellColor

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: layout.textSpacing
                        Icon {
                            id: restart
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pointSize: layout.fontSize
                            text: "\uead2"
                            color: layout.iconColor
                        }
                        
                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            text: "Restart"
                        }
                    }

                    MouseArea {
                        id: restartArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Quickshell.execDetached(["systemctl", "reboot"]);
                            root.open = false;
                        }
                    }
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
            }
        }
    }
}