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
    active: true
    PanelWindow {
       
        anchors {
            right: true
            top: true
        }

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
                Rectangle {
                    implicitWidth: background.implicitWidth
                    implicitHeight: 100
                    radius: 10
                    color: "transparent"
                    border {
                        color: Colors.secondary
                        width: 3
                    }


                }
            }

        }
    }
}