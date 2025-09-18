//components/ButtonAction.qml
import QtQuick
import App 1.0

Item {
    id:root
    width: 312
    height: 396

    signal pressed(string op)

    signal equalsLongPress()

    readonly property var ops: [
        { comp: Qt.createComponent("icons/BracketsIcon.qml"), op: "()"  },
        { comp: Qt.createComponent("icons/PlusMinusIcon.qml"), op: "neg" },
        { comp: Qt.createComponent("icons/PercentIcon.qml"),   op: "%"   },
        { comp: Qt.createComponent("icons/DivideIcon.qml"),    op: "÷"   },
        { comp: Qt.createComponent("icons/MultiplyIcon.qml"),  op: "×"   },
        { comp: Qt.createComponent("icons/MinusIcon.qml"),     op: "−"   },
        { comp: Qt.createComponent("icons/PlusIcon.qml"),      op: "+"   },
        { comp: Qt.createComponent("icons/EqualsIcon.qml"),    op: "="   }
    ]

    Row {
        id: topRow
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 24

        Repeater {
            model: 4
            delegate: CalcButton {
                width: 60; height: 60
                content: root.ops[index].comp
                onPressed: root.pressed(root.ops[index].op)
                bgN: Theme.theme_1_2
                bgA: Theme.theme_1_add_2
                tN: Theme.theme_1_6
                tA: Theme.theme_1_6
            }
        }
    }

    Column {
        id: rightCol
        anchors.top: topRow.bottom
        anchors.right: parent.right
        anchors.topMargin: 24
        spacing: 24

        Repeater {
            model: 4
            delegate: CalcButton {
                width: 60; height: 60
                content: root.ops[index + 4].comp
                onPressed: root.pressed(root.ops[index + 4].op)
                onLongPressed4s: {
                    if (root.ops[index + 4].op === "=")
                        root.equalsLongPress()
                }
                bgN: Theme.theme_1_2
                bgA: Theme.theme_1_add_2
                tN: Theme.theme_1_6
                tA: Theme.theme_1_6
            }
        }
    }
}
