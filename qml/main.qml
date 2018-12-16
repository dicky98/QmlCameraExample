import QtQuick 2.5
import QtQuick.Controls 1.5
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
    property string cameraResolution: ""

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
        
        onAvailabilityChanged: {
            if(camera.availability !== Camera.Available)
            {
                //console.log("Camera not available");
            }
            if(camera.availability === Camera.Available)
            {
                console.log("Camera available");
            }
        }
        onCameraStateChanged: {
            if(camera.cameraState === Camera.ActiveState){
                console.log("Camera ActiveState");
                //console.log("2", camera.viewfinder.resolution)
            }
            if(camera.cameraState === Camera.UnloadedState){
                //console.log("Camera disconnect unloaded");
            }
        }

        onCameraStatusChanged: {
            //console.log(camera.cameraStatus)
            if(camera.cameraStatus !== Camera.ActiveStatus){
                //console.log("Camera inactive");
                //console.log("0", viewfinder.resolution)
            }

            if(camera.cameraStatus !== Camera.UnloadedStatus){
                //console.log("Camera UnloadedStatus");
            }
            if (camera.cameraStatus === Camera.ActiveStatus) {
                console.log("Camra in active status");
                //console.log("1", viewfinder.resolution)
            }
        }

        onError: {
            camera.unlock();
            console.error("error: " + camera.errorString);
        }

        viewfinder.onResolutionChanged: {
            //console.log("1", viewfinder.resolution)
            //cameraResolution = viewfinder.resolution.width+"x"+viewfinder.resolution.height
            //console.log("1 cameraResolution ", cameraResolution)
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
    }

    CameraSetting{
        id: cameraSetting
        objectName: "cameraSetting"
        width: parent.width
        height: 200
        moveFrom: Qt.point(0,parent.height)
        moveTo:  Qt.point(0,parent.height - height)
        camera: camera
        selectedResolution: cameraResolution
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
