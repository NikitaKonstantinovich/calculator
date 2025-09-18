import QtQuick
import QtQuick.Shapes
import App 1.0

Item {
    id:root
    width: 30; height: 30
    property color ink: Theme.theme_1_6
    property real  stroke: 2

    Shape {
        anchors.fill: parent; antialiasing: true

        // левая скобка
        ShapePath {
            strokeColor: root.ink; fillColor: "transparent"
            strokeWidth: root.stroke
            startX: 12; startY: 25
                    PathArc {
                        x: 12; y: 5
                        radiusX: 3
                        radiusY: 10
                        useLargeArc: true
                    }
        }

        // правая скобка
        ShapePath {
            strokeColor: root.ink; fillColor: "transparent"
            strokeWidth: root.stroke
            startX: 18; startY: 5
                    PathArc {
                        x: 18; y: 25
                        radiusX: 3
                        radiusY: 10
                        useLargeArc: true
                    }
        }
    }
}
