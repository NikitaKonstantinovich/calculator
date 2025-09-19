// SecretMenu.qml
import QtQuick
import QtQuick.Controls
import App 1.0

Item {
    id: secretMenu
    anchors.leftMargin: 5
    anchors.topMargin: 70

    width: 350
    height: 500

    signal back()

    Rectangle {
        anchors.fill: secretMenu
        color: Theme.theme_1_add_2
        radius: 5
    }

    BackButton {
        id: backBtn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 12
        anchors.topMargin: 400
        onClicked: secretMenu.back()
    }

    StyledText {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60
        text: "Secret menu"
        color: Theme.theme_1_6
        style: TextStyles.body_1
    }
}
