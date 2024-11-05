import QtQuick
import QtQuick.Controls


import BlackjackDeck
import BlackjackCard
import BlackjackSound


Rectangle {
    visible: true
    width: 800
    height: 600
    SoundMy {
          id: sound
      }

    property string currentCardImage: "" // Поточне зображення карти
    property int cardTarget: 0 // 0 - гравець, 1 - дилер
    Drawer {
            id: myDrawer
            width: parent.width * 0.7
            height: parent.height// Ширина Drawer (70% від ширини вікна)
            edge: Qt.LeftEdge          // Drawer відкривається при свайпі з лівого краю
            modal: true                // Робить Drawer модальним, перекриваючи основний вміст


            // Вміст Drawer
            Column {
                spacing: 10
                padding: 20

                Label {
                    text: "Menu"
                    font.bold: true
                    font.pixelSize: 24
                }

                Button {
                    text: "Home"
                    onClicked: {
                        myDrawer.close()  // Закриває Drawer при натисканні кнопки
                    }
                }
                Label {
                    text: "Сhange volume"

                    font.pixelSize: 15
                }

                Slider {
                       id: volumeSlider
                       from: 0.0
                       to: 1.0
                       stepSize: 0.1
                       value: 0.5  // Початкова гучність

                       onValueChanged: {
                           sound.setBackgroundVolume(value);  // Регулюємо гучність при зміні значення
                       }
                   }
                Switch
                {
                    id: soundSwitch
                    text: "on"
                    checked: true
                    onCheckedChanged:
                    {
                        if(soundSwitch.checked)
                        {
                            sound.backgroundSound();
                            soundSwitch.text = "sound on"

                        }
                        else
                        {
                            sound.stopBackgroundSound();
                            soundSwitch.text = "sound off"

                        }
                    }
                }

            }
        }


    Component.onCompleted: {
           sound.backgroundSound()  // Відтворення фонової музики при запуску
       }
    Image
    {
        width: parent.width
        height: parent.height
        id:backgroundTable
        source: "qrc:/table.jpg"



    Rectangle {
        id: topRight
        width: 80
        height: 120
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.rightMargin: 25

        Image {
            id: backDeck
            width: parent.width
            height: parent.height
            source: "qrc:/gray_back.png"
        }
    }

    Deck {
        id: deck
    }

    // Модель для збереження карт гравця
    ListModel {
        id: playerCardsModel
    }

    // Модель для збереження карт дилера
    ListModel {
        id: dealerCardsModel
    }

    // Поле для відображення карт гравця

    ListView {
        id: playerHand
        width: parent.width
        height: 150
        spacing: -50
        model: playerCardsModel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        orientation: ListView.Horizontal
        delegate: Image {
            width: 80
            height: 120
            source: model.imagePath
        }
    }

    // Поле для відображення карт дилера
    ListView {
        id: dealerHand
        width: parent.width
        height: 150
        spacing: -50
        model: dealerCardsModel
        anchors.top: parent.top
        anchors.topMargin: 50
        orientation: ListView.Horizontal
        delegate: Image {
            width: 80
            height: 120
            source: model.imagePath
        }
    }

    Image {
        id: cardImage
        width: 80
        height: 120
        source: currentCardImage
        x: topRight.x
        y: topRight.y
        visible: state !== "idle" // Карта видима тільки під час анімації
        state: "idle" // Початковий стан

        states: [
            State {
                name: "toPlayer"
                PropertyChanges {
                    target: cardImage
                    x: playerHand.contentX + (playerCardsModel.count * 90)
                    y: playerHand.y
                }
            },
            State {
                name: "toDealer"
                PropertyChanges {
                    target: cardImage
                    x: dealerHand.contentX + (dealerCardsModel.count * 90)
                    y: dealerHand.y
                }
            },
            State {
                name: "idle"
                PropertyChanges {
                    target: cardImage
                    x: topRight.x
                    y: topRight.y
                }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 1500 }
            }
        ]
    }

    // Таймер для блокування кнопок на 3 секунди
    Timer {
        id: buttonLockTimer
        interval: 2500 // Час блокування - 3 секунди
        repeat: false
        onTriggered: {
            playerButton.enabled = true
            dealerButton.enabled = true
        }
    }

    Button {
        id: playerButton
        text: "Взяти карту"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        enabled: !buttonLockTimer.running // Блокування кнопки під час роботи таймера
        onClicked: {
            sound.playCardSound();
            cardTarget = 0; // Вибір цілі - гравець
            var imagePath = deck.drawCard(); // Отримуємо шлях до зображення карти
            if (imagePath) {
                currentCardImage = imagePath; // Встановлюємо зображення карти
                cardImage.state = "toPlayer"; // Змінюємо стан для запуску анімації до гравця
                resetStateTimer.start(); // Запускаємо таймер для повернення в початковий стан
                playerButton.enabled = false // Блокуємо кнопки одразу після натискання
                dealerButton.enabled = false
                buttonLockTimer.start() // Запускаємо таймер для блокування на 3 секунди

            } else {
                console.log("Колода порожня або карта не повертається")
            }
        }
    }

    Button {
        id: dealerButton
        text: "Взяти карту для дилера"
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        enabled: !buttonLockTimer.running // Блокування кнопки під час роботи таймера
        onClicked: {
            cardTarget = 1; // Вибір цілі - дилер
            var imagePath = deck.drawCard(); // Отримуємо шлях до зображення карти
            if (imagePath) {
                currentCardImage = imagePath; // Встановлюємо зображення карти
                cardImage.state = "toDealer"; // Змінюємо стан для запуску анімації до дилера
                resetStateTimer.start(); // Запускаємо таймер для повернення в початковий стан
                playerButton.enabled = false // Блокуємо кнопки одразу після натискання
                dealerButton.enabled = false
                buttonLockTimer.start() // Запускаємо таймер для блокування на 3 секунди
            } else {
                console.log("Колода порожня або карта не повертається")
            }
        }
    }

    Timer {
        id: resetStateTimer
        interval: 1500 // Час анімації
        repeat: false
        onTriggered: {
            if (cardTarget === 0) {
                playerCardsModel.append({"imagePath": currentCardImage}); // Додаємо карту гравцю
            } else {
                dealerCardsModel.append({"imagePath": currentCardImage}); // Додаємо карту дилеру
            }
            currentCardImage = ""; // Скидаємо зображення карти
            cardImage.state = "idle"; // Повертаємося в початковий стан
        }
    }
    }
}

