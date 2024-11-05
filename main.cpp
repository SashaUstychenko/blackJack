#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "deck.h"
#include "card.h"
#include "sound.h"
#include "game.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    qmlRegisterType<Deck>("BlackjackDeck",1,0,"Deck");
    qmlRegisterType<Card>("BlackjackCard",1,0,"Card");
    qmlRegisterType<Sound>("BlackjackSound",1,0,"SoundMy");
    qmlRegisterType<Game>("BlackjackGame",1,0,"Game");

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
