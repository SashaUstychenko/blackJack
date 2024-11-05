#ifndef DEALER_H
#define DEALER_H
#include <QObject>
#include "participant.h"

class Dealer : public Participant {
    Q_OBJECT

public:
    explicit Dealer(QObject *parent = nullptr);

    bool shouldDrawCard() const;                 // Визначає, чи дилер повинен брати ще карту
    void playTurn();                             // Виконує автоматичний хід дилера
    bool isBusted() const override;              // Перевіряє, чи є перебір
    void clearHand() override;                   // Очищає руку для нового раунду

protected:
    int calculateScore() const override;         // Обчислює рахунок дилера
};

#endif // DEALER_H
