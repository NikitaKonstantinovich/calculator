import QtQuick
import QtQuick.Shapes
import App 1.0

Item {
    id: root
    width: 30; height: 30
    property color ink: Theme.theme_1_6
    property real  stroke: 2

    Item {
        id:icon
        width: 19
        height: 19

        anchors.left: root.left
        anchors.top: root.top
        anchors.leftMargin: 5.5
        anchors.topMargin: 5.5

        Shape {
            anchors.fill: parent
            antialiasing: true
            ShapePath {
                strokeColor: ink
                strokeWidth: stroke
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 9.5; startY: 19
                PathLine { x: 9.5; y: 0 }
                PathMove { x: 0; y: 9.5 }
                PathLine { x: 19; y: 9.5 }
            }
        }
    }
}
