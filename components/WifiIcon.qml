// components/WifiIcon.qml
import QtQuick
import App 1.0

Item {
    id: root
    width: 23
    height: 14
    property color color: Theme.theme_1_6           // активный
    property color dimColor: Theme.theme_1_3_30    // пассивный
    property int quality: 2

    property int widthActive: width / 3 * quality
    property int heightActive: height / 3 * quality

    CircularSector {
        baseLength: root.width
        radius: root.height
        fillColor: root.color
        strokeColor: root.color
        strokeWidth: 0
    }

    CircularSector {
        baseLength: root.width
        radius: root.height
        fillColor: root.dimColor
        strokeColor: root.dimColor
        strokeWidth: 0
    }

    CircularSector {
        baseLength: root.widthActive
        radius: root.heightActive
        fillColor: root.color
        strokeColor: root.color
        strokeWidth: 0
        anchors.bottom: root.bottom
        anchors.horizontalCenter: root.horizontalCenter
    }
}
