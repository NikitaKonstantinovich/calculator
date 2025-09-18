//components/TextResult.qml
import QtQuick
import App 1.0

Item {
    id: root
    width: 281
    height: 60

    readonly property int maxPx: 50
    readonly property int minPx: 18

    property var model

    Text {
        id: result
        anchors.fill: parent
        anchors.right: root.right
        anchors.rightMargin: 2
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        color: Theme.theme_1_6
        text:  model ? model.display : "0"

        font.pixelSize: root.maxPx
        minimumPixelSize: root.minPx
        fontSizeMode: Text.Fit

        wrapMode: Text.NoWrap
        elide: Text.ElideNone
        maximumLineCount: 1
    }
}
