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
       property bool showFirstPage: true

       // Таймер для затримки на 4 секунди
       Timer
       {
           interval: 1000  // 4 секунди
           running: true   // Запуск автоматично при старті
           repeat: false   // Запустити тільки один раз
           onTriggered: showFirstPage = false  // Перемикаємося на другу сторінку
       }

       // Перша сторінка


       // Друга сторінка
       Initial
       {
           visible: showFirstPage
           anchors.fill: parent
       }
       Test1
       {
           visible: !showFirstPage
           anchors.fill: parent
       }


}
