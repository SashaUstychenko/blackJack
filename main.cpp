#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "deck.h"
#include "card.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Card>("BlackjackCard",1,0,"Card");
    qmlRegisterType<Deck>("BlackjackDeck",1,0,"Deck");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/blackjack/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
