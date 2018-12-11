#include "pixmapimage.h"
#include <QDebug>
//#include <opencv/cv.hpp>

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
}

void PixmapImage::onGetFrame(QImage &image)
{
    if(!image.isNull()){
        //cv::Mat frameMat(image.height(), image.width(), CV_8UC4, (void*)image.bits(), image.bytesPerLine());
        //cv::imshow("frameMat",frameMat);
        //cv::waitKey(1);

        QImage frameTmp;
        QSize parentSize = QSize(this->parent()->property("width").toDouble(),this->parent()->property("height").toDouble());
        if(parentSize.width() >= image.width()){
            //frameTmp = image.scaledToHeight(parentSize.height());
        }
        else{
            //frameTmp = image.scaledToWidth(parentSize.width());
        }

        pixmap = QPixmap::fromImage(image.copy());
        setSize(parentSize);

        frameCounter++;
        std::time_t timeNow = std::time(0) - timeBegin;
        if (timeNow - tick >= 1) {
            tick++;
            fps = frameCounter;
            frameCounter = 0;
        }
        //qDebug() << fps;
    }
    else{
        //pixmap.load("C:/Users/Zong-Ye/Desktop/16-1.PNG");
    }
    update();
}
