#include "game.h"
#include <QDebug>

Game::Game(QObject *parent) : QObject(parent), deck_(this), player_(this), dealer_(this) {
    startNewGame();
}

void Game::startNewGame() {
    resetGame();
}
void Game::resetGame() {
    deck_.resetDeck();
    player_.clearHand();
    dealer_.clearHand();

    playerBet_ = 0; // Очищення ставки
    emit gameReset(); // Повідомляємо QML про початок нової гри
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
    if (result.contains("Гравець виграє")) {
        handleWin(); // Додаємо виграш до балансу
    }
    emit roundEnded(result); // Сигнал для відображення результату
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
void Game::handleWin() {
    player_.adjustBalance(playerBet_ * 2); // Додаємо виграш до балансу (подвійна ставка)
}

void Game::handleBetResults(bool playerWon) {
    int betAmount = player_.bet();
    if (playerWon) {
        player_.adjustBalance(betAmount * 2);  // Подвоюємо виграш
    }
    player_.placeBet(0);  // Очищуємо ставку після раунду
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

int Game::getPlayerBalance()const
{
   return player_.balance();

}
// Game.cpp
void Game::setPlayerBet(int bet) {
    playerBet_ = bet;
    player_.placeBet(bet);  // Встановлюємо ставку гравця
}


void Game::placeBet(int amount) {
    player_.placeBet(amount);  // Викликає метод для встановлення ставки у гравця
    startNewGame();  // Після встановлення ставки починається новий раунд
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
