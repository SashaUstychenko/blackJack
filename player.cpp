#include "player.h"

#include "player.h"

Player::Player(QObject *parent) : Participant(parent), balance_(1000), currentBet_(0) {
    // Ініціалізуємо гравця з початковим балансом
}

int Player::balance() const {
    return balance_;
}

int Player::bet() const {
    return currentBet_;
}

void Player::placeBet(int amount) {
    if (amount <= balance_) {
        currentBet_ = amount;
        balance_ -= amount;
        // Можливо, відправити сигнал про зміну балансу
    } else {
        // Обробка помилки: недостатньо коштів
        qWarning("Недостатньо коштів для ставки");
    }
}

void Player::adjustBalance(int amount) {
    balance_ += amount;
    // Можливо, відправити сигнал про зміну балансу
}

bool Player::isBusted() const {
    return score() > 21;
}

void Player::clearHand() {
    Participant::clearHand();
    currentBet_ = 0;
}

int Player::calculateScore() const {
    int totalScore = 0;
    int aceCount = 0;

    for (const auto& card : hand_) {
        int cardValue = static_cast<int>(card->rank());
        if (card->rank() >= Card::Jack) {
            cardValue = 10; // Карти з картинками варті 10 очок
        } else if (card->rank() == Card::Ace) {
            cardValue = 11; // Спочатку Туз рахується як 11
            ++aceCount;
        }
        totalScore += cardValue;
    }

    // Коригуємо рахунок, якщо є Тузи і перебір
    while (totalScore > 21 && aceCount > 0) {
        totalScore -= 10; // Змінюємо Туз з 11 на 1
        --aceCount;
    }

    return totalScore;
}
