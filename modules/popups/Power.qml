import QtQuick
import Quickshell
import QtQuick.Layouts
import qs.configs
import qs.components

//POWER, SLEEP, LOCK, RESTART
// add text of button name underneath icon (DONE)
// add highlighting on hover
// add button functionality
// create layerrule for it in hypr.config for animation
// connect to power button

LazyLoader {
    id: root
    active: true
    PanelWindow {
        anchors {
            top: true
            right: true
        }

        color: "transparent"
        margins.right: 10
        margins.top: 5
        implicitWidth: layout.implicitWidth + 15
        implicitHeight: layout.implicitHeight + 15

        Rectangle {
            anchors.fill: parent
            color: Colors.tertiary
            radius: 10

            RowLayout {
                id: layout

                spacing: 12
                anchors.fill: parent
                property real fontSize: 25
                property int bordWidth: 3
                property color bordColor: Colors.primary
                property real bordRadius: 5
                property color cellColor: "transparent"
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
                    color: layout.cellColor
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
                    Layout.leftMargin: 10
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
                
                Rectangle {
                    implicitWidth: layout.cellHeight
                    implicitHeight: layout.cellWidth
                    border.color: layout.bordColor
                    border.width: layout.bordWidth
                    radius: layout.bordRadius
                    color: layout.cellColor
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
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Rectangle {
                    implicitWidth: layout.cellHeight
                    implicitHeight: layout.cellWidth
                    border.color: layout.bordColor
                    border.width: layout.bordWidth
                    radius: layout.bordRadius
                    color: layout.cellColor
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
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Rectangle {
                    implicitWidth: layout.cellHeight
                    implicitHeight: layout.cellWidth
                    border.color: layout.bordColor
                    border.width: layout.bordWidth
                    radius: layout.bordRadius
                    color: layout.cellColor

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
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
            }
        }
    }
}