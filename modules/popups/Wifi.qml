// Network Panel
// Turn on and off wifi
// Show nearby available networks (by strength and security?) (DONE)
//      - Show if nearby networks are secure or not
// Connect to nearby networks (DONE)
//      - ability to enter password
// Disconnect from current wifi connection 
// Forget network connection

//when selecting network transition into item that loads specifically the network name and options to connect etc, then back to regular

// FIX ANIMATION ON WIFI SELECT
// 
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Networking
import qs.services
import qs.components

LazyLoader {
    id: root
    active: false
    onActiveChanged: NetworkService.wirelessDevice.scannerEnabled = active

    PanelWindow {
        id: window
        anchors {
            right: true
            top: true
        }

        implicitHeight: 650
        implicitWidth: 450
        color: "transparent"
        WlrLayershell.namespace: "popup"
        mask: Region { item: background}
        WlrLayershell.keyboardFocus: background.connectionSelected ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

        Rectangle {
            id: background
            implicitHeight: connectionSelected ? 150 : 600
            implicitWidth: connectionSelected ? 400 : 250
            radius: 10
            color: Colors.tertiary
            anchors.margins: margin
            y: margin
            state: "closed"
            property bool connectionSelected: false
            property real margin: 5

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutCirc
                }
            }

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutCirc
                }
            }

            ColumnLayout {
                id: wifiNetworks
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0
                visible: !background.connectionSelected
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
                            text: NetworkService.getWifiIcon(NetworkService.currentNetwork)
                            font.pointSize: 40
                            Layout.leftMargin: 10
                        }

                        Text {
                            text: NetworkService.currentNetwork?.name ?? "No connection"
                            font.pointSize: 15
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            background.connectionSelected = true
                            connectPanel.network = NetworkService.currentNetwork
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: availableConnections.implicitHeight
                    ListView {
                        id: availableConnections
                        clip: true
                        implicitHeight: background.implicitHeight - currentNetwork.height - 1
                        implicitWidth: parent.width
                        model: ScriptModel {
                            values: [...NetworkService.availableNetworks].sort((a,b) => {
                                if (a.signalStrength - b.signalStrength > 0) {
                                    return -1;
                                }

                                if (b.signalStrength - a.signalStrength) {
                                    return 1;
                                }

                                if (NetworkService.requiresPassword(a) && !NetworkService.requiresPassword(b)) {
                                    return -1;
                                }

                                if (NetworkService.requiresPassword(b) && !NetworkService.requiresPassword(a)) {
                                    return 1;
                                }

                                return a.name - b.name
                            })
                        }

                        delegate: Rectangle {
                            color: "transparent"
                            /*border {
                                color: Colors.secondary
                                width: 1
                            }*/
                            radius: 10
                            implicitHeight: 50
                            implicitWidth: availableConnections.implicitWidth
                            
                            RowLayout {
                                anchors.verticalCenter: parent.verticalCenter
                                Icon {
                                    Layout.leftMargin: 10
                                    text: NetworkService.getWifiIcon(modelData)
                                    font.pointSize: 18
                                }
                                Text { 
                                    text: modelData.name 
                                    font.pointSize: 12
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    background.connectionSelected = true;
                                    connectPanel.network = modelData

                                }
                            }
                        }
                    }
                }
            }
            
            Item {
                id: connectPanel
                anchors.fill: parent
                property WifiNetwork network
                visible: background.connectionSelected && background.implicitWidth == 400
                ColumnLayout {
                    anchors.centerIn: parent
                    
                    spacing: 5

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter //| Qt.AlignVCenter
                        Icon {
                            text: NetworkService.getWifiIcon(connectPanel.network)
                            font.pointSize: 15
                        }
                        Text {
                            id: wifiName
                            text: connectPanel.network?.name ?? ""
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                            font.pointSize: connectPanel.network?.known ? 13 : 11
                        }
                    }

                    RowLayout {
                        visible: !connectPanel.network?.known && NetworkService.requiresPassword(connectPanel.network)
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        property alias passField: passField
                        Text {
                            text: "Password:"
                        }

                        TextField {
                            id: passField
                            background: Rectangle {
                                implicitWidth: 300
                                implicitHeight: 10
                            }
                            echoMode: TextInput.Password
                            passwordMaskDelay: 0

                            onAccepted: {
                                if (passField.text === "") return;
                                passField.text = ""
                                connectPanel.network?.connectWithPsk(passField.text)
                            }

                            onTextChanged: incorrectPassText.visible = false
                        }
                    }

                    Text {
                        id: incorrectPassText
                        color: "yellow"
                        font.pointSize: 10
                        text: "Incorrect password"
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        visible: false
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Rectangle {
                            color: Colors.secondary
                            Layout.preferredWidth: connectPanel.network?.connected ? 75 : 60
                            Layout.preferredHeight: 30
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            radius: 10

                            Text {
                                text: connectPanel.network?.connected ? "Disconnect" : "Connect"
                                font.pointSize: 10
                                color: Colors.primary
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if(passField.visible && passField.text === "") return;

                                    if (connectPanel.network?.connected) {
                                        connectPanel.network.disconnect()
                                    } else if (connectPanel.network?.known || !NetworkService.requiresPassword(connectPanel.network)) {
                                        connectPanel.network.connect()
                                    } else {
                                        connectPanel.network.connectWithPsk(passField.text)
                                    }
                                    passField.text = ""
                                }
                            }
                        }

                        Rectangle {
                            visible: connectPanel.network?.known ?? false
                            color: Colors.secondary
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 30
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            radius: 10

                            Text {
                                text: "Forget"
                                font.pointSize: 10
                                color: Colors.primary
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: connectPanel.network.forget()
                            }
                        }
                    }

                }

                Icon {
                    text: "\udb80\udf0d"
                    font.pointSize: 15
                    visible: background.connectionSelected
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 5

                    MouseArea {
                        anchors.fill: parent
                        onClicked: background.connectionSelected = false
                    }
                }

                Connections {
                    target: connectPanel.network
                    function onConnectedChanged() {
                        background.connectionSelected = false
                    }

                    /*function onStateChanged() {
                        if (target.state === ConnectionState.Connecting)
                            background.connectionSelected = false
                    }*/

                    function onConnectionFailed(reason) {
                        if (reason == ConnectionFailReason.NoSecrets) {
                            target.forget()
                            incorrectPassText.visible = true
                        }

                        print(ConnectionFailReason.toString(reason))
                    }
                }
            }

            onConnectionSelectedChanged: incorrectPassText.visible = false

            states: [
                State {
                    name: "closed"
                    PropertyChanges { background.x: window.implicitWidth }
                },
                State {
                    name: "open"
                    PropertyChanges { background.x: window.implicitWidth - background.implicitWidth - background.margin}
                }
            ]

            transitions: [
                Transition {
                    from: "closed"
                    to: "open"
                    NumberAnimation {
                        property: "x"
                        duration: 300
                        easing.type: Easing.OutBack
                    }
                },
                Transition {
                    from: "open"
                    to: "closed"
                    SequentialAnimation{
                        NumberAnimation {
                            property: "x"
                            duration: 300
                            easing.type: Easing.OutBack
                        }
                        PropertyAction {
                            target: root
                            property: "active"
                            value: false
                        }
                    }
                }
            ]
        }

        Component.onCompleted: {
            grab.active = true
            background.state = "open"
        }

        HyprlandFocusGrab {
            id: grab
            windows: [window]
            onCleared: {
                background.state = "closed"
            }
        }
    }
}