#ifndef CARD_H
#define CARD_H

#include <QObject>

class Card : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int rank READ rank CONSTANT)
    Q_PROPERTY(int suit READ suit CONSTANT)

public:

    enum Suit { Hearts, Diamonds, Clubs, Spades };
    enum Rank { Ace1 = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack = 10, Queen = 10, King = 10,Ace11 = 11 };

    Card(Suit suit, Rank rank, QObject *parent = nullptr);


    Q_ENUM(Suit)
    Q_ENUM(Rank)

    int rank ()const
    {
        return rank_;
    }
    int suit()const
    {
        return suit_;
    }


private :
    Suit suit_;
    Rank rank_;

signals:
};

#endif // CARD_H
