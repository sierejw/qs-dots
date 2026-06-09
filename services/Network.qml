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
    readonly property var availableNetworks: { wirelessDevice?.networks?.values.filter((network) => network?.name !== currentNetwork?.name)}
    property string name: Networking.backend.toString();

    function requiresPassword(network: WifiNetwork): bool {
        if (network.security === WifiSecurityType.Open 
            || network.security === WifiSecurityType.Owe 
            || network.security === WifiSecurityType.Unknown) {
                return false
        }

        return true
    }

    function getWifiIcon (network: WifiNetwork): string {
        if (network.signalStrength > 0.8) {
            if (requiresPassword(network)) {
                if (network.known) {
                    return "\udb85\udece"
                }
                return "\udb82\udd2a"
            }
            return "\udb82\udd28"
        }

        if (network.signalStrength > 0.6) {
            if (requiresPassword(network)) {
                if (network.known) {
                    return "\udb85\udecd"
                }
                return "\udb82\udd27"
            }
            return "\udb82\udd25"
        }

        if (network.signalStrength > 0.4) {
            if (requiresPassword(network)) {
                if (network.known) {
                    return "\udb85\udecc"
                }
                return "\udb82\udd24"
            }
            return "\udb82\udd22"
        }

        if (network.signalStrength > 0.2) {
            if (requiresPassword(network)) {
                if (network.known) {
                    return "\udb85\udecb"
                }
                return "\udb82\udd21"
            }
            return "\udb82\udd1f"
        }

        if (requiresPassword(network)) {
            if (network.known) {
                    return "\udb85\udecf"
            }
            return "\udb82\udd2c"
        }
        return "\udb82\udd2f"
    }
    //onAvailableNetworksChanged: {console.log(availableNetworks)}
}