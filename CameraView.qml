import QtQuick 2.4
import QtMultimedia 5.4

CameraViewForm {
    Component.onCompleted: {
    }

    function onCppSignal ( msg ) {
        //console.log("CppSignal Recieve : " + msg) ;
        //photoPreview.source = msg;
        if(camera.imageCapture.ready)
            camera.imageCapture.capture()
    }
    /*
    property int s: 0
    property var cameraResolutionList:[]

    Component.onCompleted: {
        cameraResolutionList = camera.supportedViewfinderResolutions()
    }

    MouseArea {
        id: aaa
        anchors.fill: parent
        onClicked: {
            camera.stop()
            var index = s % cameraResolutionList.length

            console.log(JSON.stringify(cameraResolutionList[index]));
            camera.viewfinder.resolution = cameraResolutionList[index].width+"x"+cameraResolutionList[index].height
            console.log(JSON.stringify(camera.smyCameraupportedViewfinderFrameRateRanges(cameraResolutionList[index])));

            camera.start()
            console.log(camera.viewfinder.resolution)
            s++
        }
    }
    */
    MouseArea {
        id: aaa
        anchors.fill: parent
        onClicked: {
            test.myPrint("2")
            //cameraOutputView.source = camera
            //camera.imageCapture.capture()
        }
    }
}
