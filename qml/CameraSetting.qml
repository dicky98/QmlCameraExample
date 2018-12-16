import QtQuick 2.4
import QtMultimedia 5.4

CameraSettingForm {
    property bool bShowMenu: false
    property var cameraList: []
    property var deviceIdList: []
    property var cameraResolutionList: []
    property var cameraFrameRateRangesList: []
    property int defultResolution

    //console.log(JSON.stringify(QtMultimedia.availableCameras))
    Component.onCompleted: {
        //cameraListComboBox
        cameraListComboBox.textRole = "displayName"
        cameraListComboBox.model = cameraList

        //cameraSupportedViewfinderResolutionsComboBox
        cameraSupportedViewfinderResolutionsComboBox.textRole = "displayText"
        cameraSupportedViewfinderResolutionsComboBox.model = cameraResolutionList
        cameraSupportedViewfinderResolutionsComboBox.currentIndex = defultResolution

        //cameraSupportedViewfinderFrameRateRangesComboBox
        cameraSupportedViewfinderFrameRateRangesComboBox.textRole = "displayText"
        cameraSupportedViewfinderFrameRateRangesComboBox.model = cameraFrameRateRangesList

        ///init

    }

    cameraSupportedViewfinderResolutionsComboBox.onCurrentIndexChanged: {
        print("Resolution Changed")
        var selectedCameraResolutionIndex = cameraSupportedViewfinderResolutionsComboBox.currentIndex
        if(selectedCameraResolutionIndex === -1)
            return
        camera.stop()
        camera.viewfinder.resolution = cameraResolutionList[selectedCameraResolutionIndex].displayText
        camera.start()

        ///////////////
        cameraFrameRateRangesList = []
        var cameraFrameRateRangesListPre = camera.supportedViewfinderFrameRateRanges(cameraResolutionList_[selectedCameraResolutionIndex])
        for(var index = 0 ; index < cameraFrameRateRangesListPre.length ; index++){
            var displayText = cameraFrameRateRangesListPre[index].maximumFrameRate
            var maximumFrameRate = cameraFrameRateRangesListPre[index].maximumFrameRate
            var minimumFrameRate = cameraFrameRateRangesListPre[index].minimumFrameRate
            cameraFrameRateRangesList.push( { displayText:      parseInt(maximumFrameRate),
                                              maximumFrameRate: maximumFrameRate,
                                              minimumFrameRate: minimumFrameRate } )
        }
    }
    cameraSupportedViewfinderFrameRateRangesComboBox.onCurrentIndexChanged: {
        print("Fps Changed")
        var selectedCameraFrameRateRangesIndex = cameraSupportedViewfinderFrameRateRangesComboBox.currentIndex
        if(selectedCameraFrameRateRangesIndex === -1)
            return
        camera.stop()
        camera.viewfinder.maximumFrameRate = cameraFrameRateRangesList_[selectedCameraFrameRateRangesIndex].displayText
        camera.start()
    }
    cameraListComboBox.onCurrentIndexChanged: {
        print("DeviceId Changed")
        camera.stop()
        camera.deviceId = deviceIdList[cameraListComboBox.currentIndex]
        cameraSupportedViewfinderResolutionsComboBox.currentIndex = 0
        cameraSupportedViewfinderFrameRateRangesComboBox.currentIndex = 0
        camera.start()
    }


    PropertyAnimation {
        id: cameraSettingWindowMoveAnim;
        target: cameraSettingWindow;
        property: "y";
        from: bShowMenu ? moveFrom.y : moveTo.y;
        to: bShowMenu ? moveTo.y : moveFrom.y;
        duration: 500;
        easing.type: Easing.InOutQuad;
        //loops:Animation.Infinite
        onRunningChanged:{

        }
        onStarted: {
            if(bShowMenu)
            {
                cameraSettingWindow.visible = true;
            }
        }
        onStopped: {
            if(!bShowMenu)
            {
                cameraSettingWindow.visible = false;
            }
        }
    }

    //NumberAnimation { id: theAnim; target: infoSheet.parent; property: "y"; to: moveTo.y }
    function showMenuBtn()
    {
        bShowMenu = !bShowMenu
        cameraSettingWindowMoveAnim.start()
    }


}
