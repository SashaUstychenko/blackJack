import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle
{
    width: parent.width
    height: parent.height
    gradient: Gradient
    {
        GradientStop { position: 0.0; color: "black" }
        GradientStop { position: 0.2; color: "darkgreen" }
        GradientStop { position: 0.5; color: "green" }
        GradientStop { position: 0.8; color: "darkgreen" }
        GradientStop { position: 1.0; color: "black" }

    }

    Text {
        id: name
        text: qsTr("wellcome")
        font.pixelSize: 50
        font.family: "Lobster"

        anchors.centerIn: parent

    }

}
