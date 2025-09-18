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
        width: 19
        anchors.left: root.left
        anchors.top: root.top
        anchors.leftMargin: 5.5
        anchors.topMargin: 6

        Shape {
            anchors.fill: parent; antialiasing: true

            // полоса
            ShapePath {
                strokeColor: root.ink; strokeWidth: root.stroke
                fillColor: root.ink; capStyle: ShapePath.RoundCap
                startX: 0; startY: 9
                PathLine { x: 19; y: 9 }
            }

            // верхний эллипс
            ShapePath {
                strokeColor: root.ink; fillColor: root.ink
                strokeWidth: root.stroke
                startX: 9.5; startY: 0
                        PathArc {
                            x: 9.5; y: 3
                            radiusX: 1
                            radiusY: 1
                            useLargeArc: true
                        }
                        PathArc {
                            x: 9.5; y: 0
                            radiusX: 1
                            radiusY: 1
                            useLargeArc: true
                        }
            }
            // нижний эллипс
            ShapePath {
                strokeColor: root.ink; fillColor: root.ink
                strokeWidth: root.stroke
                startX: 9.5; startY: 15
                        PathArc {
                            x: 9.5; y: 18
                            radiusX: 1
                            radiusY: 1
                            useLargeArc: true
                        }
                        PathArc {
                            x: 9.5; y: 15
                            radiusX: 1
                            radiusY: 1
                            useLargeArc: true
                        }
            }
        }
    }
}
