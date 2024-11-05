#include "sound.h"

Sound::Sound(QObject *parent) : QObject(parent) {
    cardSoundPlayer_.setAudioOutput(&audioOutput_);
    audioOutput_.setVolume(1.0);
    cardSoundPlayer_.setSource(QUrl("qrc:/soung/swish.m4a"));
    cardSoundPlayer_.setLoops(QMediaPlayer::Once);


    backgroundSound_.setAudioOutput(&audioOutput1_);
    audioOutput_.setVolume(0.5);
    backgroundSound_.setSource(QUrl("qrc:/soung/fon.mp3"));
    backgroundSound_.setLoops(QMediaPlayer::Infinite);




}

void Sound::backgroundSound()
{
    backgroundSound_.play();
}

void Sound::playCardSound() {
    cardSoundPlayer_.play();
}
void Sound::setBackgroundVolume(qreal volume) {
    // Обмежуємо гучність в межах від 0.0 до 1.0
    volume = qBound(0.0, volume, 1.0);
    audioOutput1_.setVolume(volume);  // Встановлюємо гучність для фонової музики
}
void Sound::stopBackgroundSound()
{
    backgroundSound_.stop();
}


