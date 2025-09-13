import QtQuick
import App 1.0

Item {
    id: root
    width: 16; height: 16

    // Цвета и уровень заряда
    property color color: Theme.theme_1_6           // активный
    property color bgColor: Theme.theme_1_3           // фон
    property color dimColor: Theme.theme_1_3_30    // пассивный
    property int   batteryLevel: 50   // 0..100

    Rectangle {
        id: zero
        width: 9
        height: 14
        color: root.color
        anchors.right: root.right
        anchors.rightMargin: 3
        anchors.verticalCenter: root.verticalCenter
    }

    Rectangle {
        id: body
        width: 9
        height: 14
        color: root.dimColor
        anchors.right: root.right
        anchors.rightMargin: 3
        anchors.verticalCenter: root.verticalCenter
    }

    Rectangle {
        id: fill
        height: Math.round(body.height * Math.max(0, Math.min(100, root.batteryLevel)) / 100)
        width: body.width
        color: root.color
        anchors.bottom: root.bottom
        anchors.bottomMargin: 1
        anchors.right: root.right
        anchors.rightMargin: 3
    }

    // носик сверху по центру
    Rectangle {
        width: 7; height: 2
        anchors.left: root.left
        anchors.top: root.top
        color: root.bgColor
    }
    Rectangle {
        width: 6; height: 2
        anchors.right: root.right
        anchors.top: root.top
        color: root.bgColor
    }
}
