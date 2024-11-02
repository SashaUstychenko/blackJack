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
void Deck::shuffleDeck() {

    // Ініціалізуємо випадковий генератор
    std::random_device rd;
    std::mt19937 gen(rd());  // Генератор Mersenne Twister з випадковим началом

    // Використовуємо std::shuffle для перемішування з новим генератором
    std::shuffle(cards_.begin(), cards_.end(), gen);
}
QString Deck::drawCard() {
    if (!cards_.isEmpty()) {
        auto card = cards_.takeLast();  // Витягуємо останню карту з колоди
        qDebug() << "Витягнуто карту з колоди:" << card->imagePath();  // Додаємо лог для перевірки шляху
        return card->imagePath();       // Повертаємо шлях до зображення карти
    }
    qDebug() << "Колода порожня";
    return QString();
}
