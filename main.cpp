#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QQmlProperty>
#include <QQuickItem>
#include <QDebug>

#include <QCamera>
#include <QVideoProbe>
#include <QCameraImageCapture>

#include <test.h>
//http://blog.51cto.com/9291927/1975383
//https://blog.csdn.net/henreash/article/details/8002147
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QGuiApplication::setAttribute(Qt::AA_UseOpenGLES, true);

    QQmlApplicationEngine engine;

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    //////////////////////////
    Test test;
    engine.rootContext()->setContextProperty(QStringLiteral("test"), &test);
    QObject *rootobject = engine.rootObjects().at(0);

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
