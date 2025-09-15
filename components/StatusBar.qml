//components/StatusBar.qml
import QtQuick
import QtQuick.Controls
import App 1.0

Item {
    id: root
    width: 360
    height: 24

    // Настройка
    property color bg: Theme.theme_1_3
    property color fg: Theme.theme_1_6
    property int   batteryLevel: 50           // 0..100
    property bool  wifiOn: true
    property int   signalBars: 2              // 0..4

    // — фон —
    Rectangle { anchors.fill: parent; color: root.bg }

    // Правая группа: иконки + время
    Item {
        width: 118
        height: 24
        id: content
        anchors.left: root.left
        anchors.leftMargin: 242
        anchors.verticalCenter: root.verticalCenter

        // Wifi
        WifiIcon {
            quality: 2
            anchors.left: content.left
            anchors.leftMargin: 12
            anchors.top: content.top
            anchors.topMargin: 4
        }

        // Сотовая связь
        CellularIcon {
            signalBars: 2
            anchors.left: content.left
            anchors.top: content.top
            anchors.topMargin: 4
            anchors.leftMargin: 35
        }

        // батарея
        BatteryIcon {
            batteryLevel: 30
            anchors.left: content.left
            anchors.top: content.top
            anchors.topMargin: 4
            anchors.leftMargin: 55
        }

        // время
        Rectangle {
            id: time
            width: 36
            height: 17;
            anchors.left: content.left
            anchors.top: content.top
            color: root.bg
            anchors.leftMargin: 74
            anchors.topMargin: 3

            Text {
                id: timeTxt
                anchors.right: parent.right
                anchors.verticalCenter: time.verticalCenter
                font.family: "Roboto"
                font.pixelSize: 14
                font.weight: 500
                color: Theme.theme_1_6
                text: Qt.formatTime(new Date(), "hh:mm")
            }
            // авто-обновление каждую минуту
            Timer {
                interval: 60*1000; running: true; repeat: true
                onTriggered: timeTxt.text = Qt.formatTime(new Date(), "hh:mm")
            }
        }
    }
}
