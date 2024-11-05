import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import BlackjackDeck
import BlackjackCard
import BlackjackSound
import BlackjackGame

Rectangle {
    visible: true
    width: 800
    height: 600

    SoundMy {
        id: sound
    }

    Game {
        id: game
        onWinOccurred: displayMessage("Ви виграли!")
        onBustOccurred: displayMessage("Перебір у гравця! Ви програли.")
        onRoundEnded: displayMessage(result)
    }

    property int playerScore: 0
    property int dealerScore: 0
    property string currentCardImage: "" // Поточне зображення карти
    property int cardTarget: 0 // 0 - гравець, 1 - дилер

    function displayMessage(message) {
        resultText.text = message
        resultText.visible = true
    }

    // Повідомлення про результат гри
    Text {
        id: resultText
        text: ""
        font.pixelSize: 24
        color: "yellow"
        anchors.centerIn: parent
        visible: false
    }

    // Drawer меню для налаштувань гучності та звуку
    Drawer {
        id: myDrawer
        width: parent.width * 0.7
        height: parent.height
        edge: Qt.LeftEdge
        modal: true

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
                onClicked: myDrawer.close()
            }

            Label {
                text: "Change volume"
                font.pixelSize: 15
            }

            Slider {
                id: volumeSlider
                from: 0.0
                to: 1.0
                stepSize: 0.1
                value: 0.5
                onValueChanged: sound.setBackgroundVolume(value)
            }

            Switch {
                id: soundSwitch
                text: "Sound"
                checked: true
                onCheckedChanged: {
                    if (soundSwitch.checked) {
                        sound.backgroundSound();
                        soundSwitch.text = "Sound ON";
                    } else {
                        sound.stopBackgroundSound();
                        soundSwitch.text = "Sound OFF";
                    }
                }
            }
        }
    }

    function drawCardForPlayerF() {
        cardTarget = 0;
        var imagePath = game.drawCardForPlayer();
        if (imagePath) {
            currentCardImage = imagePath;
            playerScore = game.getScopePlayer();
            cardImage.state = "toPlayer";
            resetStateTimer.start();
        } else {
            console.log("Колода порожня або карта не повертається");
        }
    }

    function drawCardForDealerF() {
        cardTarget = 1;
        var imagePath = game.drawCardForDealer();
        if (imagePath) {
            currentCardImage = imagePath;
            dealerScore = game.getScopeDealer();
            cardImage.state = "toDealer";
            resetStateTimer.start();
        } else {
            console.log("Колода порожня або карта не повертається");
        }
    }

    // Початкове відтворення фонової музики та старт гри
    Component.onCompleted: {
        sound.backgroundSound();
        firstTimer.start();
    }

    // Таймери для роздачі початкових карт
    Timer {
        id: firstTimer
        interval: 3000
        repeat: false
        onTriggered: {
            drawCardForPlayerF();
            secondTimer.start();
        }
    }

    Timer {
        id: secondTimer
        interval: 3000
        repeat: false
        onTriggered: {
            drawCardForPlayerF();
            thirdTimer.start();
        }
    }

    Timer {
        id: thirdTimer
        interval: 3000
        repeat: false
        onTriggered: {
            drawCardForDealerF();
            resetStateTimer.start();
        }
    }

    // Фонова таблиця
    Image {
        width: parent.width
        height: parent.height
        id: backgroundTable
        source: "qrc:/table.jpg"
    }

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

    // Відображення рахунку гравця
    Text {
        id: playerScoreText
        text: "Очки гравця: " + playerScore
        font.pixelSize: 24
        anchors.bottom: playerHand.top
        anchors.horizontalCenter: playerHand.horizontalCenter
        color: "white"
    }

    // Відображення рахунку дилера
    Text {
        id: dealerScoreText
        text: "Очки дилера: " + dealerScore
        font.pixelSize: 24
        anchors.bottom: dealerHand.top
        anchors.horizontalCenter: dealerHand.horizontalCenter
        color: "white"
    }
    Text {
        id: results

        font.pixelSize: 24
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
    }

    ListModel {
        id: playerCardsModel
    }
    ListModel {
        id: dealerCardsModel
    }

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
        visible: state !== "idle"
        state: "idle"

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

    Timer {
        id: buttonLockTimer
        interval: 2500
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
        enabled: !buttonLockTimer.running
        onClicked: {
            sound.playCardSound();
            drawCardForPlayerF();
            buttonLockTimer.start();
        }
    }

    Button {
        id: dealerButton
        text: "Зупинитися"
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        enabled: !buttonLockTimer.running
        onClicked: {
            sound.playCardSound();
            dealerStartDelayTimer.start();  // Запускаємо таймер для паузи перед автоматичним добором
            buttonLockTimer.start();

        }
    }

    // Таймер для початкової паузи перед початком автоматичного добору
    Timer {
        id: dealerStartDelayTimer
        interval: 1000  // Затримка перед початком автоматичного добору (1 секунда)
        repeat: false
        onTriggered: {
            dealerAutoDrawTimer.start();

            // Запускаємо основний таймер для автоматичного добору карт після паузи
        }
    }

    // Основний таймер для добору карт дилером із затримкою між картами
    Timer {
        id: dealerAutoDrawTimer
        interval: 1500  // Інтервал між доборами карт (затримка між кожною картою)
        repeat: true
        onTriggered: {
            if (game.shouldDealerDraw()) {
                drawCardForDealerF();  // Дилер бере карту
                dealerDrawPauseTimer.start();  // Запускаємо таймер для затримки між картами
                dealerAutoDrawTimer.stop();
                results.text = game.determineWinner();
                // Зупиняємо основний таймер на час паузи
            } else {
                dealerAutoDrawTimer.stop();  // Зупиняємо таймер, коли карти більше брати не потрібно
                game.endRound();  // Завершуємо раунд і визначаємо переможця
            }
        }
    }

    // Таймер для затримки між доборами карт дилером
    Timer {
        id: dealerDrawPauseTimer
        interval: 1500  // Додаткова затримка між кожною картою
        repeat: false
        onTriggered: {
            dealerAutoDrawTimer.start();  // Перезапускаємо основний таймер для наступного добору карти
        }
    }

    Timer {
        id: resetStateTimer
        interval: 1500
        repeat: false
        onTriggered: {
            if (cardTarget === 0) {
                playerCardsModel.append({"imagePath": currentCardImage});
            } else {
                dealerCardsModel.append({"imagePath": currentCardImage});
            }
            currentCardImage = "";
            cardImage.state = "idle";
        }
    }
}
