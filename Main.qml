//Main.qml
import QtQuick
import QtQuick.Controls
import App 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 360; height: 640
    color: Theme.theme_1_1

    CalculatorModel { id: calc }

    property bool showSecret: true

    SecretMenu {
        id: secret
        z: 1
        anchors.top: parent.top
        anchors.left: parent.left
        visible: showSecret
        onBack: showSecret = false
    }

    StatusBar {
        anchors.top: parent.top
        anchors.left: parent.left
    }

    BackCalculation {
        botRadius: 26
        model: calc
    }

    ButtonAction {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 24
        anchors.topMargin:  204

        onPressed: (op) => {
            switch (op) {
            case "()":
                calc.pressBrackets(); break;
            case "neg":
                calc.toggleSign();    break;
            case "%":
                calc.percent();       break;
            case "+": case "−": case "-":
            case "×": case "÷": case "*": case "/":
                calc.pressOp(op);     break;
            case "=":
                calc.equals();        break;
            }
        }
    }

    ButtonSimple {
        id: digitsPad
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 24
        anchors.topMargin:  288

        onKeyPressed: (k) => {
            if (k >= "0" && k <= "9")       calc.inputDigit(Number(k))
            else if (k === ".")             calc.inputDot()
            else console.warn("Unknown key:", k)
        }
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

        onPressed: calc.clearEntry()
        onLongPressed2s: calc.clearAll()
    }

}
