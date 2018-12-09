#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QQmlProperty>
#include <QQuickItem>
#include <QDebug>

#include <QCamera>

#include "cameraframegrabber.h"
#include "test.h"
#include "pixmapimage.h"

/*#pragma comment(lib, "opencv_core340d.lib")
#pragma comment(lib, "opencv_imgcodecs340d.lib")
#pragma comment(lib, "opencv_videoio340d.lib")
#pragma comment(lib, "opencv_imgproc340d.lib")
#pragma comment(lib, "opencv_highgui340d.lib")*/
#pragma comment(lib, "opencv_world340d.lib")

//http://blog.51cto.com/9291927/1975383
//https://blog.csdn.net/henreash/article/details/8002147
int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    //QGuiApplication::setAttribute(Qt::AA_UseDesktopOpenGL, true);
    QGuiApplication::setAttribute(Qt::AA_UseOpenGLES, true);
    //QGuiApplication::setAttribute(Qt::AA_UseSoftwareOpenGL, true);

    qmlRegisterType<PixmapImage>("PixmapImage", 1, 0, "PixmapImage");

    QQmlApplicationEngine engine;

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    //////////////////////////
    Test test;
    engine.rootContext()->setContextProperty(QStringLiteral("test"), &test);
    QObject *rootobject = engine.rootObjects().at(0);

    /////////////////////////
    QCamera *camera_;
    CameraFrameGrabber* _cameraFrameGrabber;

    QObject *qmlCamera = rootobject->findChild<QObject*>("camera");
    QObject *cameraView = rootobject->findChild<QObject*>("cameraView");
    QObject *pixmapImage = rootobject->findChild<QObject*>("pixmapImage");
    if(qmlCamera != nullptr && pixmapImage!= nullptr)
    {
        camera_ = qvariant_cast<QCamera*>(qmlCamera->property("mediaObject"));
        _cameraFrameGrabber = new CameraFrameGrabber();
        camera_->setViewfinder(_cameraFrameGrabber);
        QObject::connect(_cameraFrameGrabber, SIGNAL(frameAvailable(QImage)), pixmapImage, SLOT(onGetFrame(QImage)));
        //QObject::connect(_cameraFrameGrabber, SIGNAL(frameAvailable(QImage)), cameraView, SLOT(onCppSignal(QVariant)));
    }
    else
    {
        qDebug() << "not found camera";
    }

    /////////////////////////
    //myCamera->start();


    /////////////////////////
    QObject* page1Form = rootobject->findChild<QObject*>("page1Form");
    if(page1Form != nullptr)
    {
        page1Form->dumpObjectInfo();

        QVariant returnValue;
        QMetaObject::invokeMethod(page1Form,"qmlFunction",
                            Q_RETURN_ARG(QVariant, returnValue), // 接收QML函式回傳的值。
                            Q_ARG(QVariant, "msg!!")) ; // 傳送一個QVariant型態的msg至qmlFunction()中

        QObject::connect(page1Form, SIGNAL(qmlSignal(QString)),
                           &test, SLOT(qmlSlot(QString)));
        QObject* rect = page1Form->findChild<QObject*>("textField1");//查找名称为“rect”的元素
        if(rect)
        {
          rect->setProperty("text", "blue");//设置元素的color属性值
        }
    }
    else
    {
        qDebug() << "not found page1Form";
    }

    //////////////////////////

    return app.exec();
}
