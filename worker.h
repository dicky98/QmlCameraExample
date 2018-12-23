#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QCamera>
#include "cameraframegrabber.h"
#include <QDebug>
#include <QImage>
#include <QMutex>

class Worker : public QObject
{
    Q_OBJECT
public:
    explicit Worker(QObject *parent = nullptr);

public slots:
    void doWork() {
        qDebug() << "!!";
        camera_ = new QCamera;
        _cameraFrameGrabber = new CameraFrameGrabber();
        camera_->setViewfinder(_cameraFrameGrabber);
        QObject::connect(_cameraFrameGrabber, SIGNAL(frameAvailable(QImage&)), this, SLOT(onGetFrame(QImage&)));
        camera_->start();
    }
    void onGetFrame(QImage& result) {
        //qDebug() << "resultReady";
        mutex.lock();
        QImage frameTmp = result.copy();
        emit resultReady(frameTmp);
        mutex.unlock();
    }
private:
    QCamera *camera_;
    CameraFrameGrabber* _cameraFrameGrabber;
    QMutex mutex;
signals:
    void resultReady(QImage&);
};
#endif // WORKER_H
