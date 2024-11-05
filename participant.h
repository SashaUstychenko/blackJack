#ifndef PARTICIPANT_H
#define PARTICIPANT_H

#include <QObject>

#include <QObject>
#include <QVector>
#include <memory>
#include "card.h"

class Participant : public QObject {
    Q_OBJECT

public:
    explicit Participant(QObject *parent = nullptr);
    virtual ~Participant() = default;

    void addCard(std::shared_ptr<Card> card);    // Додає карту до руки
    int score() const;                           // Обчислює та повертає поточний рахунок
    virtual void clearHand();                    // Очищає руку для нового раунду
    virtual bool isBusted() const = 0;           // Перевіряє, чи є перебір (понад 21 очко)

protected:
    QVector<std::shared_ptr<Card>> hand_;        // Карти в руці учасника
    virtual int calculateScore() const = 0;      // Обчислює рахунок на основі карт у руці
};


#endif // PARTICIPANT_H
