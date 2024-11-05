#ifndef PLAYER_H
#define PLAYER_H
#include "participant.h"

class Player : public Participant {
    Q_OBJECT

public:
    explicit Player(QObject *parent = nullptr);

    int balance() const;                         // Повертає поточний баланс гравця
    int bet() const;                             // Повертає поточну ставку гравця
    void placeBet(int amount);                   // Встановлює ставку
    void adjustBalance(int amount);              // Змінює баланс гравця на вказану суму
    bool isBusted() const override;              // Перевіряє, чи є перебір
    void clearHand() override;                   // Очищає руку для початку нового раунду

protected:
    int calculateScore() const override;         // Обчислює рахунок гравця

private:
    int balance_;                                // Баланс гравця
    int currentBet_;                             // Поточна ставка
};


#endif // PLAYER_H
