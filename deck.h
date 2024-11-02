#ifndef DECK_H
#define DECK_H

#include <QObject>
#include <QVector>
#include <memory>
#include "card.h"

class Deck : public QObject {
    Q_OBJECT

public:
    explicit Deck(QObject *parent = nullptr);
    void shuffleDeck();
    Q_INVOKABLE QString drawCard();        // Витягує карту з колоди

private:
    void initializeDeck();             // Ініціалізує колоду карт
    QVector<std::shared_ptr<Card>> cards_;  // Колода карт
};

#endif // DECK_H
