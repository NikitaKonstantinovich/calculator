pragma Singleton
import QtQuick

QtObject {
    property FontLoader openSans: FontLoader { source:  Qt.resolvedUrl("components/fonts/OpenSans-Var.ttf") }
    readonly property string openSansFamily:
            openSans.status === FontLoader.Ready ? openSans.name : "Open Sans"

    readonly property int semiboldWeight: Font.DemiBold

    // Body_1 (50/60, 0.5px)
    property var body_1: ({
        family: openSansFamily,
        weight: semiboldWeight,
        pixelSize: 50,
        lineHeight: 60,
        lineHeightMode: Text.FixedHeight,
        letterSpacing: 0.5
    })

    // Body_2 (20/30, 0.5px)
    property var body_2: ({
        family: openSansFamily,
        weight: semiboldWeight,
        pixelSize: 20,
        lineHeight: 30,
        lineHeightMode: Text.FixedHeight,
        letterSpacing: 0.5
    })

    // Button (24/30, 1px)
    property var button: ({
        family: openSansFamily,
        weight: semiboldWeight,
        pixelSize: 24,
        lineHeight: 30,
        lineHeightMode: Text.FixedHeight,
        letterSpacing: 1
    })
}
