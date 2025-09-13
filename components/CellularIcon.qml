import QtQuick
import App 1.0
import QtQuick.Shapes

Item {
    id: root
    width: 16; height: 16

    // Цвета и уровень заряда
    property color color: Theme.theme_1_6           // активный
    property color dimColor: Theme.theme_1_3_30    // пассивный
    property int   signalBars: 2   // 0..allBars
    property int   allBars: 4   // 0..4

    Item {
        id: shape
        width: 14; height: 14
        anchors.left: root.left
        anchors.verticalCenter: root.verticalCenter

        property int bars: Math.max(0, Math.min(root.allBars, root.signalBars))
        readonly property real activePx: (width * bars) / root.allBars

        Shape {
            id:triangle
            anchors.fill: parent
            antialiasing: true

        // === 1) Фон (неактивный) — сплошной треугольник цветом 1_3_30 ===
            ShapePath {
                fillColor: root.color
                strokeColor: "transparent"
                strokeWidth: 0

                startX: shape.width;  startY: shape.height
                PathLine { x: shape.width; y: 0 }
                PathLine { x: 0;          y: shape.height }
                PathLine { x: shape.width; y: shape.height }
            }
            ShapePath {
                fillColor: root.dimColor
                strokeColor: "transparent"
                strokeWidth: 0

                startX: shape.width;  startY: shape.height
                PathLine { x: shape.width; y: 0 }
                PathLine { x: 0;          y: shape.height }
                PathLine { x: shape.width; y: shape.height }
            }
        // === 2) Активная часть ===
            ShapePath {
                fillColor: root.color
                strokeColor: "transparent"
                strokeWidth: 0

                startX: 0;  startY: shape.height
                PathLine { x: shape.activePx; y: shape.height }
                PathLine {
                    x: shape.activePx
                    y: shape.height - (shape.height/shape.width) * shape.activePx
                }
                PathLine { x: 0;  y: shape.height }
            }
        }
    }
}
