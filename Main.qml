//Main.qml
import QtQuick
import QtQuick.Controls
import App 1.0

ApplicationWindow {
    visible: true
    width: 360; height: 640
    color: Theme.theme_1_4_50

    // не 'undefined'
    Component.onCompleted: console.log("Theme check:", Theme.theme_1_3)

    CalcButton {
        z: 1
        text: "1"
    }
}
