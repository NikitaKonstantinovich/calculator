// components/BackButton.qml
import QtQuick
import QtQuick.Controls
import App 1.0

Control {
    id: root
    signal clicked()

    implicitWidth: 80
    implicitHeight: 60
    padding: 0

    background: Rectangle {
        anchors.fill: root
        radius: height/4
        color: root.pressed
                         ? Theme.theme_1_add_2
                         : root.hovered
                             ? Theme.theme_1_4
                             : Theme.theme_1_2
        border.color: Theme.theme_1_6
        border.width: 1
    }

    contentItem: StyledText {
        anchors.centerIn: parent
        text: "Back"
        style: TextStyles.button
        color: Theme.theme_1_6
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        fit: false
        font.pixelSize: 24
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}
