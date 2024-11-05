#include "game.h"
#include <QDebug>

Game::Game(QObject *parent) : QObject(parent), deck_(this), player_(this), dealer_(this) {
    startNewGame();
}

void Game::startNewGame() {
    deck_.resetDeck();
    player_.clearHand();
    dealer_.clearHand();
    emit gameStarted();
}

QString Game::drawCardForPlayer() {
    auto card = deck_.drawCard();
    if (card) {
        player_.addCard(card);
        checkForBust();  // Перевіряємо перебір після додавання карти
        return card->imagePath();
    } else {
        qWarning("Колода порожня. Неможливо витягнути карту для гравця.");
        return QString();
    }
}

QString Game::drawCardForDealer() {
    auto card = deck_.drawCard();
    if (card) {
        dealer_.addCard(card);
        checkForBust();
        return card->imagePath();
    } else {
        qWarning("Колода порожня. Неможливо витягнути карту для дилера.");
        return QString();
    }
}

void Game::endRound() {
    while (dealer_.shouldDrawCard()) {
        drawCardForDealer();
    }
    QString result = determineWinner();
    emit roundEnded(result);
}

QString Game::determineWinner() const {
    if (player_.isBusted()) {
        return "Перебір у гравця! Дилер виграє.";
    } else if (dealer_.isBusted()) {
        return "Перебір у дилера! Гравець виграє.";
    } else if (player_.score() > dealer_.score()) {
        return "Гравець виграє!";
    } else if (dealer_.score() > player_.score()) {
        return "Дилер виграє!";
    } else {
        return "Нічия!";
    }
}

void Game::resetGame() {
    deck_.resetDeck();
    player_.clearHand();
    dealer_.clearHand();
    startNewGame();
}

int Game::getScopePlayer() {
    return player_.score();
}

int Game::getScopeDealer() {
    return dealer_.score();
}

bool Game::shouldDealerDraw() const {
    return dealer_.shouldDrawCard();
}

void Game::checkForBust() {
    if (player_.score() == 21) {
        emit winOccurred("Ви досягли 21 очка! Ви виграли.");
        emit roundEnded("Гравець виграє з 21 очком.");
    } else if (player_.isBusted()) {
        emit bustOccurred("Перебір у гравця! Ви програли.");
        emit roundEnded("Перебір у гравця! Дилер виграє.");
    } else if (dealer_.isBusted()) {
        emit roundEnded("Перебір у дилера! Гравець виграє.");
    }
}
