import QtQuick
import QtQuick.Controls


import BlackjackDeck
import BlackjackCard


Rectangle {
    visible: true
    width: 800
    height: 600

    Rectangle
    {
        width: 80
        height: 120
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.rightMargin: 25

        Image {
            id: backDeck
            width:parent.width
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
        spacing: 10
        model: playerCardsModel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        orientation: ListView.Horizontal
        delegate: Image {
            width: 80
            height: 120
            source: model.imagePath  // Відображення зображення карти
        }
    }

    // Поле для відображення карт дилера
    ListView {
        id: dealerHand
        width: parent.width
        height: 150
        spacing: 10
        model: dealerCardsModel
        anchors.top: parent.top
        anchors.topMargin: 50
        orientation: ListView.Horizontal
        delegate: Image {
            width: 80
            height: 120
            source: model.imagePath  // Відображення зображення карти
        }
    }

    // Кнопка для витягування карт гравця
    Button {
        text: "Взяти карту"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        onClicked: {
            var imagePath = deck.drawCard();  // Отримуємо шлях до зображення карти
            if (imagePath) {
                console.log("Карта взята для гравця:", imagePath);
                playerCardsModel.append({"imagePath": imagePath});  // Додаємо карту до моделі гравця
            } else {
                console.log("Колода порожня або карта не повертається");
            }
        }
    }

    // Кнопка для витягування карт дилера
    Button {
        text: "Взяти карту для дилера"
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        onClicked: {
            var imagePath = deck.drawCard();  // Отримуємо шлях до зображення карти
            if (imagePath) {
                console.log("Карта взята для дилера:", imagePath);
                dealerCardsModel.append({"imagePath": imagePath});  // Додаємо карту до моделі дилера
            } else {
                console.log("Колода порожня або карта не повертається");
            }
        }
    }
}
