#ifndef GAME_H
#define GAME_H

#include <QObject>
#include "deck.h"
#include "player.h"
#include "dealer.h"

class Game : public QObject {
    Q_OBJECT

public:
    explicit Game(QObject *parent = nullptr);

    Q_INVOKABLE void startNewGame();             // Починає нову гру
    Q_INVOKABLE QString drawCardForPlayer();     // Витягує карту для гравця та повертає шлях до зображення
    Q_INVOKABLE QString drawCardForDealer();     // Витягує карту для дилера та повертає шлях до зображення
    Q_INVOKABLE void endRound();                 // Завершує раунд, визначаючи переможця
    Q_INVOKABLE void resetGame();                // Перезапускає гру
    Q_INVOKABLE int getScopePlayer();            // Повертає очки гравця
    Q_INVOKABLE int getScopeDealer();
    Q_INVOKABLE QString determineWinner() const ;      // Повертає очки дилера
    Q_INVOKABLE bool shouldDealerDraw() const;   // Повертає `true`, якщо дилер повинен добирати карту

signals:
    void gameStarted();                          // Сигнал про початок гри
    void playerTurn();                           // Сигнал про хід гравця
    void dealerTurnStarted();                    // Сигнал про хід дилера
    void roundEnded(QString result);             // Сигнал про завершення раунду з результатом
    void winOccurred(QString result);            // Сигнал про виграш
    void bustOccurred(const QString &message);   // Сигнал про перебір у гравця

private:
    Deck deck_;                                  // Колода карт
    Player player_;                              // Гравець
    Dealer dealer_;                              // Дилер

    void checkForBust();                         // Перевіряє, чи є перебір у гравця або дилера
};

#endif // GAME_H
