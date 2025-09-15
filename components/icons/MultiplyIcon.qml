import QtQuick
import QtQuick.Shapes

Item {
    width: 30; height: 30
    property color ink: Theme.theme_1_6
    property real  stroke: 2

    Shape {
        anchors.fill: parent; antialiasing: true
        ShapePath {
            strokeColor: ink; strokeWidth: stroke
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap; joinStyle: ShapePath.RoundJoin

            startX: width*0.25; startY: height*0.25
            PathLine { x: width*0.75; y: height*0.75 }
            PathMove { x: width*0.75; y: height*0.25 }
            PathLine { x: width*0.25; y: height*0.75 }
        }
    }
}
