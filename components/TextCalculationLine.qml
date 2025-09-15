import QtQuick
import App 1.0

Item {
    id: root
    width: 280
    height: 30

    Text {
        id: calcLine
        anchors.verticalCenter: root.verticalCenter
        anchors.right: root.right
        anchors.rightMargin: 2
        font.pixelSize: 20
        font.weight: 600
        font.letterSpacing: 0.5
        color: Theme.theme_1_6
        text: "368"
    }

}
