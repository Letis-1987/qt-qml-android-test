import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 640
    title: "Android Ninja App"

    background: Rectangle {
        color: Palette.window
    }

    Text {
        anchors.centerIn: parent
        text: "Собрано через Ninja + Clang!"
        font.pixelSize: 22
        font.bold: true
        color: Palette.text
    }
}
