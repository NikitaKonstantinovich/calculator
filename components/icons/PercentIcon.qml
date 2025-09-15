import QtQuick
import QtQuick.Shapes

Item {
    width: 30; height: 30
    property color ink: Theme.theme_1_6
    property real  stroke: 2

    Shape {
        anchors.fill: parent; antialiasing: true

        // диагональ
        ShapePath {
            strokeColor: ink; strokeWidth: stroke
            fillColor: "transparent"; capStyle: ShapePath.RoundCap
            startX: width*0.25; startY: height*0.75
            PathLine { x: width*0.75; y: height*0.25 }
        }

        // верхняя «точка»
        ShapePath {
            strokeColor: "transparent"; fillColor: ink
            startX: width*0.35 + 3; startY: height*0.25
            PathArc { x: width*0.35 - 3; y: height*0.25; radiusX: 3; radiusY: 3; useLargeArc: true }
            PathArc { x: width*0.35 + 3; y: height*0.25; radiusX: 3; radiusY: 3; useLargeArc: true }
        }
        // нижняя «точка»
        ShapePath {
            strokeColor: "transparent"; fillColor: ink
            startX: width*0.65 + 3; startY: height*0.75
            PathArc { x: width*0.65 - 3; y: height*0.75; radiusX: 3; radiusY: 3; useLargeArc: true }
            PathArc { x: width*0.65 + 3; y: height*0.75; radiusX: 3; radiusY: 3; useLargeArc: true }
        }
    }
}
