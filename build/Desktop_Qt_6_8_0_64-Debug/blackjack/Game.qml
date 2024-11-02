import QtQuick
import QtQuick.Controls

Rectangle
{
    width: 640
    height: 480

    ListModel {
          id: elementModel
      }

      Column {
          anchors.fill: parent
          spacing: 10

          Button {
              text: "Додати елемент"
              onClicked: {
                  // Додаємо новий елемент в модель при кожному натисканні
                  elementModel.append({ id: "newElement" + elementModel.count })
              }
          }

          // Повторювач для створення елементів на основі моделі
          Repeater {
              model: elementModel

              Rectangle {

                  width: 150
                  height: 40
                  Text
                  {
                      text: "гравець" +(index+1)
                  }
              }
          }
      }

}
