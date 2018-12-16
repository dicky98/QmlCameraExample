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
    //property string cameraResolution: ""
    property var cameraList_: []
    property var deviceIdList_: []
    property var cameraResolutionList_: []
    property var cameraFrameRateRangesList_: []
    property int defultResolutionIndex_: 0
    property int defultFpsIndex_: 0
    property bool isNeedToGetCameraList: true

    Camera {
        objectName: "camera"
        id: camera

        imageProcessing {
            //whiteBalanceMode: CameraImageProcessing.WhiteBalanceManual
        }

        exposure {
            exposureMode: Camera.ExposureManual
            //exposureCompensation: -1.0
        }

        focus.focusMode: Camera.FocusManual
        flash.mode: Camera.FlashOff
        
        onAvailabilityChanged: {
            if(camera.availability !== Camera.Available)
            {
                console.log("Camera is not available");
            }
            if(camera.availability === Camera.Available)
            {
                console.log("Camera is available");
            }
        }

        onCameraStateChanged: {
            if(camera.cameraState === Camera.ActiveState){
                //console.log("Camera is ActiveState");

                if(isNeedToGetCameraList){
                    print("isNeedToGetCameraList")
                    cameraList_ = QtMultimedia.availableCameras

                    for(var index = 0 ; index < cameraList_.length ; index++){
                        deviceIdList_.push(cameraList_[index].deviceId)
                    }

                    //cameraResolutionList
                    var cameraResolutionList_pre = camera.supportedViewfinderResolutions()
                    for(var index = 0 ; index < cameraResolutionList_pre.length ; index++){
                        var displayText = cameraResolutionList_pre[index].width + "x" + cameraResolutionList_pre[index].height
                        cameraResolutionList_.push({displayText: displayText})
                        if(camera.viewfinder.resolution === Qt.size( cameraResolutionList_pre[index].width, cameraResolutionList_pre[index].height)){
                            defultResolutionIndex_ = index
                        }
                    }

                    //cameraFrameRateRangesList
                    var cameraFrameRateRangesList_pre = camera.supportedViewfinderFrameRateRanges(cameraResolutionList_[defultResolutionIndex_])
                    for(var index = 0 ; index < cameraFrameRateRangesList_pre.length ; index++){
                        var maximumFrameRate = cameraFrameRateRangesList_pre[index].maximumFrameRate;//cameraFrameRateRangesList[index].minimumFrameRate + "\n" + cameraFrameRateRangesList[index].maximumFrameRate
                        var minimumFrameRate = cameraFrameRateRangesList_pre[index].minimumFrameRate;
                        //cameraFrameRateRangesListModel.append({displayText: displayText})
                        cameraFrameRateRangesList_.push( { displayText:      parseInt(maximumFrameRate),
                                                           maximumFrameRate: maximumFrameRate,
                                                           minimumFrameRate: minimumFrameRate } )
                        if(camera.viewfinder.maximumFrameRate === maximumFrameRate){
                            defultFpsIndex_ = index
                        }
                    }

                    isNeedToGetCameraList = false
                }

            }
            if(camera.cameraState === Camera.UnloadedState){
                //console.log("Camera disconnect unloaded");
            }
        }

        onCameraStatusChanged: {
            //console.log(camera.cameraStatus)
            if(camera.cameraStatus === Camera.LoadedStatus){
                //console.log("Camera inactive");
            }

            if(camera.cameraStatus !== Camera.UnloadedStatus){
                //console.log("Camera UnloadedStatus");
            }
            if (camera.cameraStatus === Camera.ActiveStatus) {
                //console.log("Camera is ActiveStatus");
                //console.log("0", viewfinder.resolution)
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

        onDeviceIdChanged: {
            print("onDeviceIdChanged")
            isNeedToGetCameraList = true
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
        cameraList: cameraList_
        deviceIdList: deviceIdList_
        cameraResolutionList: cameraResolutionList_
        cameraFrameRateRangesList: cameraFrameRateRangesList_
        selectedCameraResolutionIndex: defultResolutionIndex_
        selectedCameraFrameRateRangesIndex: defultFpsIndex_
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
