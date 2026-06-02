import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.modules.bar.components
import qs.modules.popups
import qs.configs
Scope {
    Variants {
        model: Quickshell.screens
        id: scope

        PanelWindow {
            required property var modelData
            screen: modelData
        
            id: bar
            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 50
            color: "transparent"

            Rectangle {
                id: background
                anchors.fill: parent
                color: Colors.primary
                visible: true
            }

            OsLogo {
                id: osLogo
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            Workspaces {
                id: workspaces
                anchors.left: osLogo.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
            }
            
            ClockWidget {
                id:clock
                anchors.centerIn: parent
            }

            SystemTray {
                id: tray
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
            }
        }
    }
}