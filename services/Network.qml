pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking
import Quickshell.Hyprland

Singleton {
    readonly property WiredDevice ethernetDevice: Networking.devices.values.find((device) => device.type === DeviceType.Wired) ?? null
    readonly property WifiDevice wirelessDevice: Networking.devices.values.find((device) => device.type === DeviceType.Wifi) ?? null
    readonly property bool wifiEnabled: Networking.wifiEnabled
    readonly property Network currentNetwork: wirelessDevice?.networks?.values.find((network) => network.connected) ?? null
    readonly property var availableNetworks: { wirelessDevice?.networks?.values.filter((network) => network.name !== currentNetwork.name)}
    property string name: Networking.backend.toString();

    //onAvailableNetworksChanged: {console.log(availableNetworks)}
}