import QtQuick
import QtQuick.Shapes

Item {
    id:root
    width: 30; height: 30
    property color ink: Theme.theme_1_6
    property real  stroke: 2

    Item {
        id:icon
        width: 22
        height: 16
        anchors.left: root.left
        anchors.top: root.top
        anchors.leftMargin: 4
        anchors.topMargin: 7

        Shape {
            anchors.fill: parent; antialiasing: true

            ShapePath {
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap


                // горизонтальная линия
                startX: 0; startY: 4
                PathLine { x: 8; y: 4 }

                // вертикальная линия
                PathMove { x: 4; y: 0 }
                PathLine { x: 4; y: 8 }
            }

            ShapePath {
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap


                // /-линия
                startX: 8; startY: 16
                PathLine { x: 14; y: 0 }
            }

            ShapePath {
                strokeWidth: 2
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap


                // горизонтальная линия
                startX: 14; startY: 12
                PathLine { x: 22; y: 12 }
            }
        }
    }
}
