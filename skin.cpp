#include "skin.h"

Skin::Skin(QObject *parent)
    : QObject(parent), backImage_("qrc:/gray_back.png") // Default image
{
}

QString Skin::backImage() const {
    return backImage_;
}

void Skin::setBackImage(const QString &newBackImage) {
    if (backImage_ != newBackImage) {
        backImage_ = newBackImage;
        emit backImageChanged();
    }
}
