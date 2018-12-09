#ifndef MYCAMERA_H
#define MYCAMERA_H

#include <QObject>
#include <QCamera>

class MyCamera : public QCamera
{
    Q_OBJECT
public:
    MyCamera();
};

#endif // MYCAMERA_H
