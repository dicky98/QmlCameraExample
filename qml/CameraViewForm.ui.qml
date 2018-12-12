import QtQuick 2.4
import QtQuick.Controls 1.5
import QtMultimedia 5.4
import PixmapImage 1.0

Item {
    property alias pixmapImage: pixmapImage

    PixmapImage {
        id: pixmapImage
        objectName: "pixmapImage"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter:  parent.verticalCenter
        //anchors.fill: parent
        //width: parent.width
        //height: parent.height
        //autoOrientation: true
    }
}
