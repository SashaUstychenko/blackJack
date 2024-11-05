#include "dealer.h"

Dealer::Dealer(QObject *parent) : Participant(parent) {
    // Ініціалізуємо дилера
}

bool Dealer::shouldDrawCard() const {
    return score() < 17;  // Дилер бере карти, поки рахунок менше 17
}

bool Dealer::isBusted() const {
    return score() > 21;
}

void Dealer::clearHand() {
    Participant::clearHand();
}

int Dealer::calculateScore() const {
    int totalScore = 0;
    int aceCount = 0;

    for (const auto& card : hand_) {
        int cardValue = static_cast<int>(card->rank());
        if (card->rank() >= Card::Jack) {
            cardValue = 10;  // Карти з картинками варті 10 очок
        } else if (card->rank() == Card::Ace) {
            cardValue = 11;  // Спочатку Туз рахується як 11
            ++aceCount;
        }
        totalScore += cardValue;
    }

    while (totalScore > 21 && aceCount > 0) {
        totalScore -= 10;  // Змінюємо Туз з 11 на 1
        --aceCount;
    }

    return totalScore;
}
