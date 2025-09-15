import QtQuick
import App 1.0

Item {
    id: root
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 24
    width: 360
    height: 156
    property int botRadius: 16

    Rectangle {
        anchors.fill: parent
        color: Theme.theme_1_3
        radius: 0
        topLeftRadius: 0
        topRightRadius: 0
        bottomLeftRadius: root.botRadius
        bottomRightRadius: root.botRadius
    }

    TextCalculationLine {
        anchors.top: root.top
        anchors.left: root.left
        anchors.topMargin: 44
        anchors.leftMargin: 39
    }

    TextResult {
        anchors.top: root.top
        anchors.left: root.left
        anchors.topMargin: 82
        anchors.leftMargin: 39

    }
}
