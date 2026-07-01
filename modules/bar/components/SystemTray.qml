import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import qs.modules.bar.components
import qs.modules.lock
import qs.components
import qs.modules.popups
import qs.services

//TODO: move battery to its own service
//TODO: add layer disable when user doesn't touches outside of layer for all popups

Rectangle {
    id: root
    implicitWidth: trayRow.implicitWidth
    implicitHeight: trayRow.implicitHeight + 15
    color: Colors.tertiary
    radius: 10

    required property Lock lock

    Volume{id:volume}
    Power{
        id:power
        lock: root.lock
    }
    Wifi{id: wifi}

    RowLayout {
        id: trayRow
        anchors.fill: parent
        spacing: 12

        Loader {
            sourceComponent: RowLayout {
                spacing:1
                Icon {
                    id: batteryIcon
                    text: {
                        const battPercentage = Math.floor(UPower.displayDevice.percentage * 10) * 10
                        const charging = [UPowerDeviceState.PendingCharge, UPowerDeviceState.Charging, UPowerDeviceState.FullyCharged].includes(UPower.displayDevice.state)

                        if (charging) {
                            return battIcons.chargeIcons[battPercentage]
                        }

                        return battIcons.icons[battPercentage]
                    }
                    color: Colors.secondary
                }

                Text {
                    text: Math.round(100 * UPower.displayDevice.percentage)
                    color: Colors.secondary
                    font.family: "Liberation Mono"
                    font.pointSize: 10
                }
            }
            Layout.leftMargin: 5
        }

        Loader {
            sourceComponent: Rectangle {
                id: soundIconCont
                implicitWidth: 20
                implicitHeight: soundIcon.implicitHeight
                color: "transparent"

                Icon {
                    id: soundIcon
                    text: AudioService.getSoundIcon()
                    color: Colors.secondary
                    anchors.left: parent.left
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(!volume.active)
                            volume.active = !volume.active
                        volume.open = !volume.open
                    }
                }
            }
        }
        

        Loader {
            sourceComponent: Icon {
                id: wifiIcon
                text: "\udb81\udda9"
                color: Colors.secondary
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!wifi.active)
                        wifi.active = !wifi.active
                    wifi.open = !wifi.open
                }
            }
        }

        /*Loader {
            sourceComponent: Icon {
                id: bluetoothIcon
                text: "\udb80\udcaf"
                color: Colors.secondary
                visible: false
            }
            active: false
        }

        Loader {
            sourceComponent: Icon {
                id: settingsIcon
                text: "\ueaf8"
                color: Colors.secondary
            }
            active: false
        }*/

        Loader {
            sourceComponent: Icon {
                id: powerIcon
                text: "\uf011"
                color: Colors.secondary

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (!power.active)
                            power.active = !power.active
                        power.open = !power.open
                    }
                }
            }

            Layout.rightMargin: 5
        }
    }

    QtObject {  //might need to be moved to config file
        id: battIcons

        property var icons: {
            100: "\udb80\udc79",
            90:  "\udb80\udc82",
            80:  "\udb80\udc81",
            70:  "\udb80\udc80",
            60:  "\udb80\udc7f",
            50:  "\udb80\udc7e",
            40:  "\udb80\udc7d",
            30:  "\udb80\udc7c",
            20:  "\udb80\udc7b",
            10:  "\udb80\udc7a",
            0:   "\udb80\udc8e"
        }

        property var chargeIcons: {
            100: "\udb80\udc85",
            90:  "\udb80\udc8b",
            80:  "\udb80\udc8a",
            70:  "\udb82\udc9e",
            60:  "\udb80\udc89",
            50:  "\udb82\udc9d",
            40:  "\udb80\udc88",
            30:  "\udb80\udc87",
            20:  "\udb80\udc86",
            10:  "\udb82\udc9c",
            0:   "\udb82\udc9f"
        }
    }
}

