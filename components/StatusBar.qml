//components/StatusBar.qml
import QtQuick
import QtQuick.Controls
import App 1.0

Item {
    id: root
    width: parent ? parent.width : 360
    height: 24

    // Настройка
    property color bg: Theme.theme_1_3
    property color fg: Theme.theme_1_6
    property int   batteryLevel: 50           // 0..100
    property bool  wifiOn: true
    property int   signalBars: 2              // 0..4

    // — фон —
    Rectangle { anchors.fill: parent; color: root.bg }

    // Правая группа: иконки + время
    Row {
        id: right
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8


        // Сотовая связь — треугольник из 4 секций
        Item {
            id: cellular
            width: 16; height: 16

            Item {
                id: shape
                width: 14; height: 14
                anchors.centerIn: parent
                visible: root.signalBars > 0

                // 0..4, с защитой от мусора
                property int bars: Math.max(0, Math.min(4, root.signalBars))
                property color on:  root.fg
                property color off: Qt.rgba(1,1,1,0.30)

                Canvas {
                    id: cellCanvas
                    anchors.fill: parent
                    antialiasing: false

                    onPaint: {
                        const ctx = getContext("2d");
                        const w = Math.floor(width);
                        const h = Math.floor(height);
                        ctx.clearRect(0, 0, w, h);

                        const steps = 4;                 // 4 вертикальные секции
                        for (let i = 0; i < steps; ++i) {
                            // вертикальные границы текущей секции
                            const x0 = Math.floor(i     * w / steps);
                            const x1 = Math.floor((i+1) * w / steps);

                            // высота треугольника на левой/правой границе секции
                            // гипотенуза идёт от (0,h) до (w,0)
                            const y0 = Math.floor(h - (x0 * h / w));
                            const y1 = Math.floor(h - (x1 * h / w));

                            // цвет секции: слева направо заполняем i < bars
                            ctx.fillStyle = (i < shape.bars) ? shape.on : shape.off;

                            // секция — трапеция (первая слева выродится в треугольник)
                            ctx.beginPath();
                            ctx.moveTo(x0, h);     // низ слева
                            ctx.lineTo(x1, h);     // низ справа
                            ctx.lineTo(x1, y1);    // верх справа по гипотенузе
                            ctx.lineTo(x0, y0);    // верх слева по гипотенузе
                            ctx.closePath();
                            ctx.fill();
                        }
                    }

                    // перерисовка при изменениях и на старте
                    Connections {
                        target: shape
                        function onBarsChanged()  { cellCanvas.requestPaint() }
                        function onOnChanged()    { cellCanvas.requestPaint() }
                        function onOffChanged()   { cellCanvas.requestPaint() }
                        function onWidthChanged() { cellCanvas.requestPaint() }
                        function onHeightChanged(){ cellCanvas.requestPaint() }
                    }
                    Component.onCompleted: requestPaint()
                }
            }
        }


        Item {
            id: battery
            width: 16; height: 16

            // корпус
            Rectangle {
                id: body
                width: 9; height: 13
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                radius: 2
                color: "transparent"
                border.color: root.fg
                border.width: 1
                antialiasing: false
            }

            // уровень заряда: снизу вверх
            Rectangle {
                anchors.left: body.left
                anchors.right: body.right
                anchors.bottom: body.bottom
                anchors.margins: 2
                height: Math.max(0, (parent.height - 4) * root.batteryLevel/100)
                radius: 1
                color: root.fg
                antialiasing: false
            }

            // носик сверху по центру
            Rectangle {
                width: 3; height: 1
                anchors.bottom: body.top
                anchors.horizontalCenter: body.horizontalCenter
                color: root.fg
                radius: 1
            }
        }
        // время
        Rectangle {
            width: 36
            height: 17;
            anchors.verticalCenter: parent.verticalCenter
            color: root.bg
            anchors.rightMargin: 8

            Text {
                id: time
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 4
                anchors.bottomMargin: 1
                font.family: "Roboto"
                font.pixelSize: 14
                font.weight: Font.Medium
                color: Theme.theme_1_6
                text: Qt.formatTime(new Date(), "hh:mm")
            }
            // авто-обновление каждую минуту
            Timer {
                interval: 60*1000; running: true; repeat: true
                onTriggered: time.text = Qt.formatTime(new Date(), "hh:mm")
            }
        }
    }
}
