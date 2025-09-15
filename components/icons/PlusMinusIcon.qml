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
            fillColor: "transparent"; capStyle: ShapePath.RoundCap

            // плюс (верх)
            startX: width*0.2; startY: height*0.35
            PathLine { x: width*0.8; y: height*0.35 }
            PathMove { x: width*0.5; y: height*0.15 }
            PathLine { x: width*0.5; y: height*0.55 }

            // минус (низ)
            PathMove { x: width*0.2; y: height*0.75 }
            PathLine { x: width*0.8; y: height*0.75 }
        }
    }
}
