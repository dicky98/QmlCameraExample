#ifndef CAMERAFRAMEGRABBER_H
#define CAMERAFRAMEGRABBER_H

#include <QObject>
#include <QAbstractVideoSurface>
#include <QList>

class CameraFrameGrabber : public QAbstractVideoSurface
{
    Q_OBJECT
public:
    explicit CameraFrameGrabber(QObject *parent = 0);

    QList<QVideoFrame::PixelFormat> supportedPixelFormats(QAbstractVideoBuffer::HandleType handleType) const;

    bool present(const QVideoFrame &frame);

signals:
    void frameAvailable(QImage &frame);
    void cppSignal ( QVariant msg ) ;

public slots:

};

#endif // CAMERAFRAMEGRABBER_H
