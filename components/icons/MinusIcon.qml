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
            capStyle: ShapePath.RoundCap

            startX: width*0.2; startY: height*0.5
            PathLine { x: width*0.8; y: height*0.5 }
        }
    }
}

