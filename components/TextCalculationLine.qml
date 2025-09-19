import QtQuick
import App 1.0

Item {
    id: root
    width: 280
    height: 30

    property var model

    StyledText {
        id: calcLine
        anchors.verticalCenter: root.verticalCenter
        anchors.right: root.right
        anchors.rightMargin: 2
        style: TextStyles.body_2
        color: Theme.theme_1_6
        text: model ? model.expression : ""
        elide: Text.ElideLeft
    }
}
