// components/CircularSector.qml
import QtQuick
import QtQuick.Shapes
import App 1.0

Item {
    id: root

    // Входные параметры
    property real baseLength: 23    // L — длина верхнего основания
    property real radius:     14    // R — радиус окружности (= высота треугольника)

    // Оформление
    property color fillColor: Theme.theme_1_3  // если нужен именно сектор — сделай не transparent
    property color strokeColor: Theme.theme_1_3     // цвет дуги
    property real  strokeWidth: 0

    // Габариты контейнера: по ширине берём L, по высоте — R
    width:  baseLength
    height: radius

    // Центр окружности (совпадает с вершиной треугольника)
    // В нашей системе координат (0,0) — левый верхний угол Item.
    // Основание сверху на y = 0, значит центр внизу на оси симметрии: (L/2, R)
    readonly property real cx: width / 2
    readonly property real cy: height

    // Векторы к концам основания из центра: (±L/2, -R)
    // Углы к этим точкам:
    readonly property real alphaDeg: Math.atan2(radius, baseLength/2) * 180 / Math.PI
    // Левая точка основания (угол ближе к -180°): -180° + alpha
    readonly property real leftAngleDeg:  -180 + alphaDeg
    // Правая точка основания (угол ближе к   0°): -alpha
    readonly property real rightAngleDeg: -alphaDeg
    // Короткая дуга «под основанием» (уверенно через верх): sweep = right - left > 0
    readonly property real sweepDeg: rightAngleDeg - leftAngleDeg   // = 180° - 2*alpha

    Shape {
        anchors.fill: parent
        antialiasing: true

        // Если нужен "сектор" (дуга + два радиуса) — включи этот путь и дай fillColor ≠ transparent
        // Иначе можно оставить только нижний ShapePath с дугой (stroke).
        ShapePath {
            fillColor: root.fillColor
            strokeColor: "transparent"
            strokeWidth: 0

            // Старт из центра → на левую границу сектора
            startX: cx; startY: cy
            PathLine { x: cx + radius * Math.cos((leftAngleDeg  ) * Math.PI/180);
                       y: cy + radius * Math.sin((leftAngleDeg  ) * Math.PI/180) }

            // Дуга по окружности от левого луча к правому (через верх)
            PathAngleArc {
                centerX: cx; centerY: cy
                radiusX: radius; radiusY: radius
                startAngle: leftAngleDeg
                sweepAngle: sweepDeg
            }

            // Возврат в центр — замыкаем "сектор"
            PathLine { x: cx; y: cy }
        }
    }
}
