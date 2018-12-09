#ifndef PIXMAPIMAGE_H
#define PIXMAPIMAGE_H

#include <QQuickPaintedItem>
#include <QPainter>
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

public slots:
    void onGetFrame(QImage image);

};

#endif // PIXMAPIMAGE_H
