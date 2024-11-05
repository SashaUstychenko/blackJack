

#include "participant.h"
#include <algorithm> // Для std::count_if

Participant::Participant(QObject *parent) : QObject(parent) {
    // Ініціалізуємо учасника з порожньою рукою
}

void Participant::addCard(std::shared_ptr<Card> card) {
    hand_.append(card);
}

int Participant::score() const {
    return calculateScore();
}

void Participant::clearHand() {
    hand_.clear();
}
