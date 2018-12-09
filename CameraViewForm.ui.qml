import QtQuick 2.4
import QtQuick.Controls 2.0
import QtMultimedia 5.4
import PixmapImage 1.0

Item {
    property Camera camera
    property alias cameraOutputView: cameraOutputView
    property alias photoPreview: photoPreview
    property alias pixmapImage: pixmapImage

    Image {
        id: photoPreview
        width: 300
        height: 300
    }

    PixmapImage {
        id: pixmapImage
        objectName: "pixmapImage"
        width: 640
        height: 480
        //anchors.fill: parent
    }

    VideoOutput {
        id: cameraOutputView
        visible: true
        width: parent.width
        height: parent.height

        x: 0
        y: 0

        //source: camera
        autoOrientation: true
    }
}
