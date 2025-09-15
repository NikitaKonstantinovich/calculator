import QtQuick
import QtQml
import QtQml.Models
import App 1.0

Item {
    id: root
    width: 228
    height: 312

    readonly property var keys: [
        "7","8","9",
        "4","5","6",
        "1","2","3",
        "", "0","."
    ]

    Grid {
        id: grid
        anchors.fill: parent
        columns: 3
        spacing: 24

        Repeater {
            model: root.keys

            delegate: DelegateChooser {
                role: "modelData"

                DelegateChoice {
                    roleValue: ""
                    delegate: Item { width: 60; height: 60 }
                }

                DelegateChoice {
                    delegate: CalcButton {
                        width: 60; height: 60
                        text: modelData
                        onPressed: root.pressed(text)
                    }
                }
            }
        }
    }
}
