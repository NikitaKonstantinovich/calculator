//Main.qml
import QtQuick
import QtQuick.Controls
import App 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 360; height: 640
    color: Theme.theme_1_1

    StatusBar {
        anchors.top: parent.top
        anchors.left: parent.left
    }

    BackCalculation {
        botRadius: 26
    }

    ButtonAction {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 24
        anchors.topMargin:  204
    }

    ButtonSimple {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 24
        anchors.topMargin:  288
    }

    CalcButton {
        text: "C"
        tN: Theme.theme_1_6
        tA: Theme.theme_1_6
        bgN: Theme.theme_1_5_50
        bgA: Theme.theme_1_5

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 24
        anchors.topMargin:  540
    }

}
