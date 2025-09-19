// components/StyledText.qml
import QtQuick
import App 1.0

Text {
    id: root

    property var  style: TextStyles.os24
    property bool fit: false
    property int  minPixelSize: Math.max(8, (style?.pixelSize || 24) * 0.4)

    wrapMode: Text.NoWrap
    elide: Text.ElideRight

    horizontalAlignment: Text.AlignLeft
    verticalAlignment:   Text.AlignVCenter

    font.family:            style?.family
    font.weight:            style?.weight ?? Font.DemiBold
    font.pixelSize:         style?.pixelSize ?? 24
    font.letterSpacing:     style?.letterSpacing ?? 0

    lineHeight:     style?.lineHeight     ?? 0
    lineHeightMode: style?.lineHeightMode ?? Text.ProportionalHeight

    fontSizeMode: fit ? Text.Fit : Text.FixedSize
    minimumPixelSize: minPixelSize
}
