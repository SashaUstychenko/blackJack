#ifndef SOUND_H
#define SOUND_H

#include <QObject>
#include <QAudioOutput>

#include <QMediaPlayer>
#include <QUrl>

class Sound : public QObject {
    Q_OBJECT

public:
    explicit Sound(QObject *parent = nullptr);
    Q_INVOKABLE void playCardSound();
    Q_INVOKABLE void backgroundSound();
    Q_INVOKABLE void setBackgroundVolume(qreal volume);
    Q_INVOKABLE void stopBackgroundSound();


private:
    QMediaPlayer cardSoundPlayer_;
    QMediaPlayer backgroundSound_;

    QAudioOutput audioOutput_;
    QAudioOutput audioOutput1_;

};


#endif // SOUND_H
