#ifndef SKIN_H
#define SKIN_H

#include <QObject>
#include <QString>

class Skin : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString backImage READ backImage WRITE setBackImage NOTIFY backImageChanged)

public:
    explicit Skin(QObject *parent = nullptr);

    QString backImage() const;
    Q_INVOKABLE void setBackImage(const QString &newBackImage);

signals:
    void backImageChanged();

private:
    QString backImage_;
};

#endif // SKIN_H
