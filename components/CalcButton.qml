//components/CalcButton.qml
import QtQuick
import QtQuick.Controls
import App 1.0

Control {
    id: root
    property alias text: label.text

    property bool disabled: false
    signal pressed()
    signal longPressed()

    property color bgN: Theme.theme_1_4
    property color bgA: Theme.theme_1_3
    property color tN: Theme.theme_1_1
    property color tA: Theme.theme_1_6

    implicitWidth: 60
    implicitHeight: 60
    enabled: !disabled
    hoverEnabled: true

    background: Rectangle {
        id: circle
        Rectangle {
            z: -1
            anchors.fill: parent
            radius: width/2
            color: Theme.theme_1_6
        }
        anchors.fill: parent
        radius: width/2
        color: root.hovered ? root.bgA : root.bgN
        Behavior on color { ColorAnimation { duration: 120 } }
    }

    contentItem: Text {
        id: label
        anchors.centerIn: root
        font.pixelSize: 24
        font.weight: Font.Medium
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: root.hovered ? root.tA : root.tN
    }

    // Лонг-тап: таймер 4 сек
    Timer { id: hold; interval: 4000; repeat: false; onTriggered: root.longPressed() }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor

        onPressed:  if (root.enabled) hold.start()
        onReleased: {
            if (root.enabled) {
                hold.stop()
                root.pressed()
            } else {
                hold.stop()
            }
        }
        onCanceled: hold.stop()
    }

}
