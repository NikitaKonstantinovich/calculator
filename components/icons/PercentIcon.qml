import QtQuick
import QtQuick.Shapes
import App 1.0

Item {
    id:root
    width: 30; height: 30
    property color ink: Theme.theme_1_6
    property real  stroke: 2

    Item {
        id: icon
        height: 18
        width: 18
        anchors.left: root.left
        anchors.top: root.top
        anchors.leftMargin: 6
        anchors.topMargin: 6

        Shape {
            anchors.fill: parent; antialiasing: true

            // диагональ
            ShapePath {
                strokeColor: root.ink; strokeWidth: root.stroke
                fillColor: "transparent"; capStyle: ShapePath.RoundCap
                startX: 4; startY: 17
                PathLine { x: 14; y: 1 }
            }

            // верхний эллипс
            ShapePath {
                strokeColor: root.ink; fillColor: "transparent"
                strokeWidth: root.stroke
                startX: 3; startY: 0
                        PathArc {
                            x: 3; y: 8
                            radiusX: 3
                            radiusY: 4
                            useLargeArc: true
                        }
                        PathArc {
                            x: 3; y: 0
                            radiusX: 3
                            radiusY: 4
                            useLargeArc: true
                        }
            }
            // нижний эллипс
            ShapePath {
                strokeColor: root.ink; fillColor: "transparent"
                strokeWidth: root.stroke
                startX: 15; startY: 10
                        PathArc {
                            x: 15; y: 18
                            radiusX: 3
                            radiusY: 4
                            useLargeArc: true
                        }
                        PathArc {
                            x: 15; y: 10
                            radiusX: 3
                            radiusY: 4
                            useLargeArc: true
                        }
            }
        }
    }
}
