import QtQuick 2.4
import QtMultimedia 5.4

CameraSettingForm {
    property bool bShowMenu: false
    property var cameraList: []
    property var deviceIdList: []
    property var cameraResolutionList: []
    property var cameraFrameRateRangesList: []
    property int selectedCameraResolutionIndex
    property int selectedCameraFrameRateRangesIndex
    property var selectedCameraFps: {"displayText":"", "minimumFrameRate":0, "maximumFrameRate":0}

    //console.log(JSON.stringify(ppp))
    Component.onCompleted: {
        //cameraListComboBox
        cameraListComboBox.textRole = "displayName"
        cameraListComboBox.model = cameraList

        //cameraSupportedViewfinderResolutionsComboBox
        cameraSupportedViewfinderResolutionsComboBox.textRole = "displayText"
        cameraSupportedViewfinderResolutionsComboBox.model = cameraResolutionList
        cameraSupportedViewfinderResolutionsComboBox.currentIndex = selectedCameraResolutionIndex

        //cameraSupportedViewfinderFrameRateRangesComboBox
        cameraSupportedViewfinderFrameRateRangesComboBox.textRole = "displayText"
        cameraSupportedViewfinderFrameRateRangesComboBox.model = cameraFrameRateRangesList
        //cameraSupportedViewfinderFrameRateRangesComboBox.currentIndex = selectedCameraFrameRateRangesIndex
        selectedCameraFps = cameraFrameRateRangesList[selectedCameraFrameRateRangesIndex]
        ///init

    }

    cameraSupportedViewfinderResolutionsComboBox.onCurrentIndexChanged: {
        if ( selectedCameraResolutionIndex === -1
             || selectedCameraResolutionIndex === cameraSupportedViewfinderResolutionsComboBox.currentIndex )
        {
            return
        }
        selectedCameraResolutionIndex = cameraSupportedViewfinderResolutionsComboBox.currentIndex

        print("Resolution Changed to", selectedCameraResolutionIndex)

        ///////////////
        var isUseLastResolutionFps = false
        cameraFrameRateRangesList = []
        var cameraFrameRateRangesListPre = camera.supportedViewfinderFrameRateRanges(cameraResolutionList[selectedCameraResolutionIndex])
        for(var index = 0 ; index < cameraFrameRateRangesListPre.length ; index++){
            var maximumFrameRate = cameraFrameRateRangesListPre[index].maximumFrameRate
            var minimumFrameRate = cameraFrameRateRangesListPre[index].minimumFrameRate
            cameraFrameRateRangesList.push( { displayText:      parseInt(maximumFrameRate),
                                              maximumFrameRate: maximumFrameRate,
                                              minimumFrameRate: minimumFrameRate } )
            if( selectedCameraFps.maximumFrameRate === maximumFrameRate &&
                selectedCameraFps.minimumFrameRate === minimumFrameRate ){
                isUseLastResolutionFps = true
                selectedCameraFrameRateRangesIndex = index
            }
        }

        //if(camera.lockStatus === Camera.Unlocked)
        camera.searchAndLock()
        print(camera.lockStatus)
        camera.stop()
        camera.viewfinder.resolution = cameraResolutionList[selectedCameraResolutionIndex].displayText
        if(isUseLastResolutionFps)
        {
            console.log("useLastResolutionFps")
        }
        else
        {
            console.log("noUseLastResolutionFps")
            //console.log(JSON.stringify(cameraFrameRateRangesList))
            //console.log(JSON.stringify(cameraFrameRateRangesList[cameraFrameRateRangesList.length-1]))
            //console.log(JSON.stringify(cameraFrameRateRangesList[0]))
            //print(cameraFrameRateRangesList.length-1)
            selectedCameraFrameRateRangesIndex = (cameraFrameRateRangesList.length-1)
            camera.viewfinder.maximumFrameRate = cameraFrameRateRangesList[cameraFrameRateRangesList.length-1].maximumFrameRate
            camera.viewfinder.minimumFrameRate = cameraFrameRateRangesList[cameraFrameRateRangesList.length-1].minimumFrameRate
            selectedCameraFps = cameraFrameRateRangesList[cameraFrameRateRangesList.length-1]
        }
        camera.start()
    }

    cameraSupportedViewfinderFrameRateRangesComboBox.onCurrentIndexChanged: {
        if ( selectedCameraFrameRateRangesIndex === -1
             || selectedCameraFrameRateRangesIndex === cameraSupportedViewfinderFrameRateRangesComboBox.currentIndex )
        {
            return
        }
        selectedCameraFrameRateRangesIndex = cameraSupportedViewfinderFrameRateRangesComboBox.currentIndex

        print("Fps Changed to", selectedCameraFrameRateRangesIndex)
        selectedCameraFps = cameraFrameRateRangesList[selectedCameraFrameRateRangesIndex]
        selectedCameraFrameRateRangesIndex = selectedCameraFrameRateRangesIndex
        camera.stop()
        camera.viewfinder.maximumFrameRate = cameraFrameRateRangesList[selectedCameraFrameRateRangesIndex].maximumFrameRate
        camera.viewfinder.minimumFrameRate = cameraFrameRateRangesList[selectedCameraFrameRateRangesIndex].minimumFrameRate
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
