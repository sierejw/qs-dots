import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Wayland

WlSessionLockSurface {
    id: root
    color: "transparent"
    required property LockContext context

    Rectangle {
        anchors.fill: parent
        color: "Red" 

        Button {
            text: "It's not working, let me out"
            onClicked: context.unlocked();
        }

        ColumnLayout {
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.verticalCenter
            }

            RowLayout {
                TextField {
                    id: passwordBox

                    implicitWidth: 400
                    padding: 10

                    focus: true
                    enabled: !root.context.unlockInProgress
                    echoMode: TextInput.Password
                    inputMethodHints: Qt.ImhSensitiveData

                    onTextChanged: root.context.currentText = this.text;

                    onAccepted: root.context.tryUnlock()

                    Connections {
                        target: root.context
                        function onCurrentTextChanged() {
                            passwordBox.text = root.context.currentText
                        }
                    }
                }

                Button {
                    text: "Unlock"
                    padding: 10

                    focusPolicy: Qt.NoFocus
                    enabled: !root.context.unlockInProgress && root.context.currentText !== "";
                    onClicked: root.context.tryUnlock();
                }
            }

            Label {
                visible: root.context.showFailure
                text: "Incorrect password"
            }
        }
    }
}