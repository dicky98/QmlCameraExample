#ifndef PIXMAPIMAGE_H
#define PIXMAPIMAGE_H

#include <QQuickPaintedItem>
#include <QPainter>
#include <ctime>
//#include <QPixmap>

class PixmapImage : public QQuickPaintedItem
{
    Q_OBJECT
public:
    PixmapImage(QQuickItem *parent = Q_NULLPTR);
    Q_INVOKABLE void setImage(QImage *image);

protected:
    virtual void paint(QPainter *painter) Q_DECL_OVERRIDE;

private:
    QPixmap pixmap;
    QImage frame;

    int frameCounter = 0, tick = 0, fps = 0, totalFps=0, avgFpsCount=0;
    std::time_t timeBegin = std::time(0);

public slots:
    void onGetFrame(QImage &image);

};

#endif // PIXMAPIMAGE_H
