import QtQuick
import qs.services
import qs.components

Rectangle {
    implicitWidth: osLogo.implicitWidth + 15
    implicitHeight: osLogo.implicitHeight + 15
    color: Colors.tertiary
    radius: 10

    Loader {
        id: osLogo
        sourceComponent: Icon {
            id: osLogo
            text: "\udb82\udcc7" 
            color: Colors.secondary
            font.pointSize: 20
            
        }
        anchors.centerIn: parent
    }
}