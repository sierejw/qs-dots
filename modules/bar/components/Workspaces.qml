import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.configs

Rectangle {
    id: root
    color: Colors.tertiary
    implicitWidth: container.implicitWidth + 15
    implicitHeight: container.implicitHeight + 15
    radius: 10

    RowLayout {
        id: container
        anchors.centerIn: parent
        Repeater {
            model: Hyprland.workspaces
            Rectangle {
                id: workspace
                required property var modelData
                property bool focused: Hyprland.focusedWorkspace.id === modelData.id
                implicitWidth: 10
                implicitHeight: 10
                color: Colors.secondary
                state: "INACTIVE"

                states: [
                     State {
                        name: "INACTIVE"
                        when: !focused
                        PropertyChanges { workspace.color: Colors.secondary }
                        PropertyChanges { workspace.implicitHeight: 10 }
                        PropertyChanges { workspace.implicitWidth: 10 }
                    },
                    State {
                        name: "ACTIVE"
                        when: focused
                        PropertyChanges { workspace.color: Colors.primary }
                        PropertyChanges { workspace.implicitHeight: 15 }
                        PropertyChanges { workspace.implicitWidth: 15 }
                    }
                ]

                transitions: [
                    Transition {
                        from: "INACTIVE"
                        to: "ACTIVE"
                        NumberAnimation {properties: "implicitWidth, implicitHeight";}
                    },
                    Transition {
                        from: "ACTIVE"
                        to: "INACTIVE"
                        NumberAnimation {properties: "implicitWidth, implicitHeight";}
                    }
                ]
            }
        }
    }
}

// animation for current workspace with states and transitions
// animation for creating/destroying workspace tbd?