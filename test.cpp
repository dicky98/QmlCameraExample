#include "test.h"
#include <QDEBUG>

Test::Test(QObject *parent) : QObject(parent)
{

}

void Test::myPrint(QString str)
{
    //std::cout << str << std::endl;
    qDebug() << str;
}

void Test::qmlSlot(const QString& message)
{
    qDebug() << "C++ called: " << message;
}

void Test::handleFrame(QVideoFrame f)
{
    //std::cout<<"!!"<<std::endl;
    qDebug() << "cameraView";
}

void Test::displayImage(int index, QImage img)
{
    qDebug() << QString::number(index);
}

void Test::displayFrame(int index, const QVideoFrame &frame)
{
    qDebug() << QString::number(index);
}
