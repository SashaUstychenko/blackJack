#include "card.h"
#include <QDebug>

Card::Card(Suit suit,Rank rank,QObject *parent)
    : QObject{parent},suit_(suit),rank_(rank)
{}

QString Card::imagePath()const
{
    QStringList suits = {"hearts", "diamonds", "clubs", "spades"};
    QStringList ranks = {"ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"};
    QString suitName = suits[static_cast<int>(suit_)];
    QString rankName = ranks[rank_ - 1];

    return QString("qrc:/%1_of_%2.png").arg(rankName).arg(suitName);
}
