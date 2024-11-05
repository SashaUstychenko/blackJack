#include "deck.h"
#include <QRandomGenerator>
#include <algorithm>
#include <QDebug>

Deck::Deck(QObject *parent) : QObject(parent) {
    initializeDeck();

}

void Deck::initializeDeck()
{

    cards_.clear();
    qDebug() << "Ініціалізуємо колоду карт";
    for (int suit = Card::Hearts; suit <= Card::Spades; ++suit)
    {
        for (int rank = Card::Ace; rank <= Card::King; ++rank)
        {
            cards_.append(std::make_shared<Card>(static_cast<Card::Suit>(suit),
                                                 static_cast<Card::Rank>(rank),
                                                 this));;

        }
    }
    shuffleDeck();
    qDebug() << "Колода карт готова. Кількість карт у колоді:" << cards_.size();

}
void Deck::resetDeck() {
    if (cards_.isEmpty()) {
        initializeDeck(); // Повторно ініціалізуємо колоду, якщо всі карти витягнуто
    } else {
        shuffleDeck(); // Якщо колода не порожня, просто перемішуємо її
    }
}
void Deck::shuffleDeck() {

    // Ініціалізуємо випадковий генератор
    std::random_device rd;
    std::mt19937 gen(rd());  // Генератор Mersenne Twister з випадковим началом

    // Використовуємо std::shuffle для перемішування з новим генератором
    std::shuffle(cards_.begin(), cards_.end(), gen);
}

std::shared_ptr<Card> Deck::drawCard() {
    if (!cards_.isEmpty()) {
        auto card = cards_.last();
        cards_.removeLast(); // Витягуємо останню карту з колоди
        qDebug() << "Витягнуто карту з колоди:" << card->imagePath();
        return card;
    } else {
        qWarning("Колода порожня. Немає більше карт для витягування.");
        return nullptr; // Повертає nullptr, якщо колода порожня
    }
}

