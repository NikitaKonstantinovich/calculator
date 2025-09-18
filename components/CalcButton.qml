// components/CalcButton.qml
import QtQuick
import QtQuick.Controls
import App 1.0

Control {
    id: root

    signal pressed(string key)

    // либо задаём текст, либо передаём компонент иконки в content
    property alias text: label.text
    property Component content: null

    property bool disabled: false
    signal longPressed4s()
    signal longPressed2s()

    property color bgN: Theme.theme_1_4
    property color bgA: Theme.theme_1_3
    property color tN: Theme.theme_1_1
    property color tA: Theme.theme_1_6

    implicitWidth: 60
    implicitHeight: 60
    enabled: !disabled
    hoverEnabled: true

    background: Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: root.hovered ? root.bgA : root.bgN
        Behavior on color { ColorAnimation { duration: 120 } }

        Rectangle {
            z: -1
            anchors.fill: parent
            radius: width / 2
            color: Theme.theme_1_6
        }
    }

    // единый контейнер: показываем либо иконку (Loader), либо текст (Text)
    contentItem: Item {
        anchors.fill: parent

        Loader {
            id: iconLoader
            anchors.centerIn: parent
            sourceComponent: root.content
            visible: sourceComponent !== null
        }

        Text {
            id: label
            anchors.centerIn: parent
            visible: iconLoader.sourceComponent === null
            font.pixelSize: 24
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: root.hovered ? root.tA : root.tN
        }
    }

    // лонг-тап: 4 сек
    Timer { id: hold4; interval: 4000; repeat: false; onTriggered: root.longPressed4s() }

    // лонг-тап: 2 сек
    Timer { id: hold2; interval: 2000; repeat: false; onTriggered: root.longPressed2s() }

    property bool longFired: false

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor

        onPressed: if (root.enabled) {
                       longFired = false
                       hold4.start()
                       hold2.start()
                   }
        onReleased: {
            hold4.stop()
            hold2.stop()
            if (!root.enabled) return
            if (!longFired) root.pressed(root.text)
        }
        onCanceled: {
            longFired = false
            hold4.stop()
            hold2.stop()
        }
    }
}
