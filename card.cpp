#include "card.h"

Card::Card(Suit suit,Rank rank,QObject *parent)
    : QObject{parent},suit_(suit),rank_(rank)
{}
