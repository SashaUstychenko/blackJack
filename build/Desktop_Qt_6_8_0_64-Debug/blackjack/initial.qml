import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle
{
    width: parent.width
    height: parent.height

    Text {
        id: name
        text: qsTr("wellcome")
        font.pixelSize: 50
        anchors.centerIn: parent

    }

    gradient: Gradient
    {
        GradientStop { position: 0.0; color: "forestgreen" }
        GradientStop { position: 0.3; color: "forestgreen" }
        GradientStop { position: 1.0; color: "seagreen" }

    }
}
