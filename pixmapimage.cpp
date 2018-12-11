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
    //painter->drawImage(0, 0, frame);
    painter->drawPixmap(0, 0, width(), height(), pixmap);
    update();
}

void PixmapImage::onGetFrame(QImage &image)
{
    if(!image.isNull()){
        QImage frameTmp = image.copy();
        QSize parentSize = QSize(this->parent()->property("width").toDouble(),this->parent()->property("height").toDouble());
        if(parentSize.width() >= frameTmp.width()){
            frameTmp = frameTmp.scaledToHeight(parentSize.height());
            //frameTmp = image.copy();
        }

        if(parentSize.width() < frameTmp.width()){
            frameTmp = frameTmp.scaledToWidth(parentSize.width());
            //frameTmp = image.copy();
        }

        if(parentSize.height() >= frameTmp.height()){
            frameTmp = frameTmp.scaledToWidth(parentSize.width());
            //frameTmp = image.copy();
        }

        if(parentSize.height() < frameTmp.height()){
            frameTmp = frameTmp.scaledToHeight(parentSize.height());
            //frameTmp = image.copy();
        }

        QTransform rotating;
        rotating.rotate(180);
        frameTmp = frameTmp.transformed(rotating);
        pixmap = QPixmap::fromImage(frameTmp);
        setSize(frameTmp.size());

        frameCounter++;
        std::time_t timeNow = std::time(0) - timeBegin;
        if (timeNow - tick >= 1) {
            tick++;
            fps = frameCounter;
            frameCounter = 0;
        }
        //qDebug() << fps;

        //cv::Mat frameMat(frameTmp.height(), frameTmp.width(), CV_8UC4, (void*)frameTmp.bits(), frameTmp.bytesPerLine());
        //cv::imshow("frameMat",frameMat);
        //cv::waitKey(1);
    }
    else{
        //pixmap.load("C:/Users/Zong-Ye/Desktop/16-1.PNG");
    }
}
