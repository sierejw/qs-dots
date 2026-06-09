// Network Panel



/* Pop up window with below information
*/
/* Show current connected network
    BAR CHANGES
  - show network name in bar
  - show wifi off symbol if wifi off
  - show no wifi symbol if not connected to network
  - show connection strength

    PANEL NEEDS
  - Name of connection
  - Signal strength
  
  HOW
  - Simple row with name and connection strength symbol next to it
*/
// Turn on and off wifi
// Show nearby available networks (by strength and security?)
//      - Show if nearby networks are secure or not
// Connect to nearby networks
//      - ability to enter password
// Disconnect from wifi connection
// Forget network connection
import QtQuick
import Quickshell
import Quickshell.Wayland
import QtQuick.Layouts
import qs.services
import qs.components

LazyLoader {
    id: root
    active: false
    onActiveChanged: Network.wirelessDevice.scannerEnabled = active
    PanelWindow {
       
        /*anchors {
            right: true
            top: true
        }*/

        implicitHeight: background.implicitHeight
        implicitWidth: background.implicitWidth
        color: "transparent"
        WlrLayershell.namespace: "popup"

        Rectangle {
            id: background
            implicitHeight: 500
            implicitWidth: 300
            radius: 10
            color: Colors.tertiary

            ColumnLayout {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0
                Rectangle {
                    id: currentNetwork
                    Layout.preferredWidth: background.implicitWidth
                    Layout.preferredHeight: 100
                    radius: 10
                    color: "transparent"
                    border {
                        color: Colors.secondary
                        width: 3
                    }
                    RowLayout {
                        anchors.fill: parent
                        Icon {
                            text: "\udb81\udda9"
                            font.pointSize: 40
                            Layout.leftMargin: 10
                        }

                        Text {
                            text: Network.currentNetwork?.name ?? "No connection"
                            font.pointSize: 10
                        }
                    }
                }

                ListView {
                    clip: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: background.implicitHeight - currentNetwork.height
                    model: ScriptModel {
                        values: [...Network.availableNetworks].sort((a,b) => {
                            if (a.signalStrength - b.signalStrength > 0) {
                                return -1;
                            }

                            if (b.signalStrength - a.signalStrength) {
                                return 1;
                            }

                            if (Network.requiresPassword(a) && !Network.requiresPassword(b)) {
                                return -1;
                            }

                            if (Network.requiresPassword(b) && !Network.requiresPassword(a)) {
                                return 1;
                            }

                            return a.name - b.name
                        })
                    }

                    delegate: Rectangle {
                        color: "transparent"
                        border {
                            color: Colors.secondary
                            width: 1
                        }
                        radius: 10
                        implicitHeight: 50
                        implicitWidth: background.implicitWidth
                        
                        RowLayout {
                            anchors.verticalCenter: parent.verticalCenter
                            Icon {
                                Layout.leftMargin: 10
                                text: Network.getWifiIcon(modelData)
                            }
                            Text { 
                                text: modelData.name 
                            }
                        }
                    }
                }
            }
        }
    }
}
