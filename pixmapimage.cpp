#include "pixmapimage.h"
#include <QDebug>
#include <opencv/cv.hpp>

PixmapImage::PixmapImage(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{
}

void PixmapImage::setImage(QImage *image)
{
    //PixmapContainer *pc = qobject_cast<PixmapContainer*>(pixmapContainer);
    //Q_ASSERT(image);
    pixmap = QPixmap::fromImage(*image);
    //m_pixmapContainer.pixmap = pc->pixmap;
    update();
}

void PixmapImage::paint(QPainter *painter)
{
    painter->drawPixmap(0, 0, width(), height(), pixmap);
}

void PixmapImage::onGetFrame(QImage image)
{
    qDebug() << "onGetFrame";
    if(!image.isNull()){
        //setSize(image.size());
        //setWidth(image.size().width());
        //setHeight(image.size().height());
        //pixmap = QPixmap::fromImage(image);
        cv::Mat frameMat(image.height(), image.width(), CV_8UC4, (void*)image.bits(), image.bytesPerLine());
        cv::imshow("frameMat",frameMat);
        cv::waitKey(1);
        //qDebug() << image.format();
        //qDebug() << image.size();
        //qDebug() << pixmap.size();
        //qDebug() << width() << ", " << height();

        //update();
    }
    else{
        pixmap.load("C:/Users/Zong-Ye/Desktop/16-1.PNG");
    }
    update();
}
