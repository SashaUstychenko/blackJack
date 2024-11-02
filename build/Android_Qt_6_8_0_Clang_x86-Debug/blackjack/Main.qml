import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow
{
    width: 640
    height: 480
    visible: true
    title: qsTr("BlackJack")
    // Властивість для перемикання сторінок
    ListModel {
           id: squareModel
       }

       // Repeater для відображення квадратів
       Repeater {
           model: squareModel
           delegate: Rectangle {
               width: 50
               height: 50
               color: modelData  // Встановлюємо колір з моделі

               // Розташування з динамічним зсувом
               x: index * 60  // Зсув кожного наступного квадрата по горизонталі
               y: 100
           }
       }

       // Додавання початкових квадратів
       Component.onCompleted: {
           squareModel.append("red")   // Перший квадрат червоного кольору
           squareModel.append("blue")  // Другий квадрат синього кольору
       }

       // Кнопка для додавання нових квадратів
       Button {
           text: "Додати квадрат"
           anchors.bottom: parent.bottom
           anchors.horizontalCenter: parent.horizontalCenter
           onClicked: {
               // Додаємо новий квадрат з випадковим кольором
               var colors = ["green", "yellow", "purple", "orange"]
               var randomColor = colors[Math.floor(Math.random() * colors.length)]
               squareModel.append(randomColor)
           }
       }
   }
