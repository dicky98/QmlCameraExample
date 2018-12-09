#ifndef TEST_H
#define TEST_H
#include <iostream>

#include <QObject>
#include <QVector>
#include <qDebug>

#include <QVideoFrame>

class Test : public QObject
{
    Q_OBJECT
public:
    explicit Test(QObject *parent = nullptr);
    Q_INVOKABLE void myPrint(QString str);

public slots:
    void qmlSlot(const QString& message);
    void handleFrame(QVideoFrame f);
    void displayImage(int index, QImage img);
    void displayFrame(int index, const QVideoFrame &frame);

};

#endif // TEST_H
