import QtQuick
import QtQuick.Shapes

Item {
    width: 30; height: 30
    property color ink: Theme.theme_1_6
    property real  stroke: 2

    Shape {
        anchors.fill: parent; antialiasing: true

        // черта
        ShapePath {
            strokeColor: ink; strokeWidth: stroke
            fillColor: "transparent"; capStyle: ShapePath.RoundCap
            startX: width*0.2; startY: height*0.5
            PathLine { x: width*0.8; y: height*0.5 }
        }
        // верхняя точка (малый круг)
        ShapePath {
            strokeColor: "transparent"; fillColor: ink
            startX: width*0.5 + 3; startY: height*0.22
            PathArc {
                x: width*0.5 - 3; y: height*0.22
                radiusX: 3; radiusY: 3; useLargeArc: true
            }
            PathArc {
                x: width*0.5 + 3; y: height*0.22
                radiusX: 3; radiusY: 3; useLargeArc: true
            }
        }
        // нижняя точка
        ShapePath {
            strokeColor: "transparent"; fillColor: ink
            startX: width*0.5 + 3; startY: height*0.78
            PathArc {
                x: width*0.5 - 3; y: height*0.78
                radiusX: 3; radiusY: 3; useLargeArc: true
            }
            PathArc {
                x: width*0.5 + 3; y: height*0.78
                radiusX: 3; radiusY: 3; useLargeArc: true
            }
        }
    }
}
