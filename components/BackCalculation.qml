// components/BackCalculation.qml
import QtQuick
import App 1.0

Item {
    id: root
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.topMargin: 24
    width: 360
    height: 156
    property int botRadius: 16

    property var model

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
        model: root.model
    }

    TextResult {
        anchors.top: root.top
        anchors.left: root.left
        anchors.topMargin: 82
        anchors.leftMargin: 39
        model: root.model
    }
}
