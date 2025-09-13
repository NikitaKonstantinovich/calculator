//components/WifiIcon.qml
import QtQuick
import App 1.0

Item {
    id: root
    // можно ставить любые размеры — всё масштабируется
    width: 18; height: 16

    // Цвета и качество сигнала
    property color color: Theme.theme_1_6           // активный
    property color dimColor: Theme.theme_1_3_30    // пассивный
    property int   quality: 1   // 0..3 — сколько «колец» закрасить

    // Номинальная геометрия (до масштабирования)
    readonly property real r0: 15       // радиус базовой окружности
    readonly property real triBase: 23 // длина гипотенузы (основания)
    readonly property real triH: 14    // высота треугольника (вершина в центре окружности)

    // Масштаб до текущего размера: весь знак укладываем в 30×30 (диаметр R0*2)
    readonly property real s: Math.min(width / (r0*2), height / (r0*2))

    // Толщина колец (в номинале) и радиусы трёх окружностей
    readonly property real ringThick: 2.0
    readonly property var  rings: [
        { ro: r0,                  ri: r0 - ringThick },                 // внешнее
        { ro: r0 - 4,              ri: r0 - 4 - ringThick },             // среднее
        { ro: r0 - 8,              ri: r0 - 8 - ringThick }              // внутреннее
    ]

    Canvas {
        id: cvs
        anchors.fill: parent
        antialiasing: false

        onPaint: {
            const ctx = getContext("2d");
            const W = Math.floor(width), H = Math.floor(height);
            ctx.clearRect(0, 0, W, H);

            // Центр окружности/вершина треугольника — внизу по центру
            const cx = Math.floor(W/2);
            const cy = Math.floor(H/2 + (root.r0 * root.s)/2); // центр вниз, чтобы влезло

            // --- 1) Клип-треугольник (основание — гипотенуза), вершина в (cx,cy) ---
            const base = root.triBase * root.s;
            const hh   = root.triH * root.s;
            const x0 = Math.floor(cx - base/2);
            const x1 = Math.floor(cx + base/2);
            const yb = Math.floor(cy - hh);   // линия гипотенузы
            ctx.save();
            ctx.beginPath();
            ctx.moveTo(x0, yb);   // левый конец гипотенузы
            ctx.lineTo(x1, yb);   // правый конец
            ctx.lineTo(cx, cy);   // вершина в центре окружности
            ctx.closePath();
            ctx.clip();

            // --- 2) Рисуем три «кольца» (только пересечение с клипом видно) ---
            // сколько из них активные
            const active = Math.max(0, Math.min(3, root.quality));
            for (let i = 0; i < 3; ++i) {
                const col = (i < active) ? root.color : root.dimColor;
                ring(cx, cy, root.rings[i].ro * root.s, root.rings[i].ri * root.s, col);
            }

            ctx.restore();

            // ---- helpers ----
            function ring(x, y, rOuter, rInner, fill) {
                ctx.fillStyle = fill;
                ctx.beginPath();
                ctx.arc(x, y, rOuter, 0, Math.PI*2, false);
                ctx.arc(x, y, rInner, 0, Math.PI*2, true); // вырез (OddEven)
                ctx.closePath();
                ctx.fill();
            }
        }

        // Перерисовки
        Component.onCompleted: requestPaint()
        onWidthChanged:  requestPaint()
        onHeightChanged: requestPaint()
        Connections {
            target: root
            function onColorChanged()    { cvs.requestPaint() }
            function onDimColorChanged() { cvs.requestPaint() }
            function onQualityChanged()  { cvs.requestPaint() }
        }
    }
}

