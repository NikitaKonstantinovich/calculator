import QtQuick
import QtQuick.Shapes

Item {
    width: 30; height: 30
    property color ink: Theme.theme_1_6
    property real  stroke: 2

    Shape {
        anchors.fill: parent; antialiasing: true

        // левая скобка
        ShapePath {
            strokeColor: ink; strokeWidth: stroke
            fillColor: "transparent"; capStyle: ShapePath.RoundCap; joinStyle: ShapePath.RoundJoin
            startX: width*0.40; startY: height*0.15
            PathLine { x: width*0.30; y: height*0.15 }
            PathLine { x: width*0.30; y: height*0.85 }
            PathLine { x: width*0.40; y: height*0.85 }
        }
        // правая скобка
        ShapePath {
            strokeColor: ink; strokeWidth: stroke
            fillColor: "transparent"; capStyle: ShapePath.RoundCap; joinStyle: ShapePath.RoundJoin
            startX: width*0.60; startY: height*0.15
            PathLine { x: width*0.70; y: height*0.15 }
            PathLine { x: width*0.70; y: height*0.85 }
            PathLine { x: width*0.60; y: height*0.85 }
        }
    }
}
