import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtMultimedia 5.4

ApplicationWindow {
    objectName: "main"
    visible: true
    width: 1280
    height: 720
    title: qsTr("Hello World")
    color: "black"

    property var imageSource: 0
    Camera {
        objectName: "camera"
        id: camera
        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
        captureMode: Camera.CaptureStillImage //CaptureViewfinder

        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }

        flash.mode: Camera.FlashRedEyeReduction

        imageCapture {

            onImageCaptured: {
                imageSource = preview  // Show the preview in an Image
                //console.log(preview)
                //console.log(displayName)
            }

        }



        onDisplayNameChanged: {
            console.log("onDisplayNameChanged")
        }
    }

    CameraView{
        id: cameraViewForm
        objectName: "cameraView"
        width: parent.width
        height: parent.height
        camera: camera
        photoPreview.source: imageSource
    }

    CameraSetting{
        id: cameraSetting
        objectName: "cameraSetting"
        width: parent.width
        height: 200
        moveFrom: Qt.point(0,parent.height)
        moveTo:  Qt.point(0,parent.height - height)
        camera: camera
        //anchors.bottom: parent.bottom
        //opacity: 0
    }

    Button {
        id: showMenuBtn
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        text: qsTr("setting")
        visible: true
        onClicked: cameraSetting.showMenuBtn()
    }


    /*
    MouseArea {
        anchors.fill: parent
        onClicked: {
            test.myPrint("123")
        }
    }*/
}
