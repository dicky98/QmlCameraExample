import QtQuick 2.4
import QtMultimedia 5.4

CameraSettingForm {
    property bool bShowMenu: false
    property var cameraList: []
    property var deviceIdList: []
    property var cameraResolutionList: []
    property var cameraFrameRateRangesList: []
    property int selectedResolution
    //property int selectedCameraResolutionIndex: -1
    //property int selectedCameraFrameRateRangesIndex: -1
    //property list cameraFrameRateRangesList: camera.supportedViewfinderFrameRateRanges()

    //console.log(JSON.stringify(QtMultimedia.availableCameras))
    Component.onCompleted: {
        cameraList = QtMultimedia.availableCameras
        for(var index = 0 ; index < cameraList.length ; index++){
            cameraListModel.append({displayName: cameraList[index].displayName})
            deviceIdList.push(cameraList[index].deviceId)
        }
        cameraListComboBox.textRole = "displayName"
        cameraListComboBox.model = cameraListModel

        //cameraResolutionList
        cameraResolutionList = camera.supportedViewfinderResolutions()
        for(var index = 0 ; index < cameraResolutionList.length ; index++){
            var displayText = cameraResolutionList[index].width + "x" + cameraResolutionList[index].height
            cameraResolutionListModel.append({displayText: displayText})
            if(camera.viewfinder.resolution === Qt.size( cameraResolutionList[index].width, cameraResolutionList[index].height)){
                //print("!!")
                selectedResolution = index
            }
        }
        cameraSupportedViewfinderResolutionsComboBox.textRole = "displayText"
        cameraSupportedViewfinderResolutionsComboBox.model = cameraResolutionListModel
        cameraSupportedViewfinderResolutionsComboBox.currentIndex = selectedResolution
        //cameraSupportedViewfinderResolutionsComboBox.currentText = selectedResolution
        //console.log(camera.viewfinder.maximumFrameRate)

        //cameraFrameRateRangesList
        cameraFrameRateRangesListModel.clear()
        cameraFrameRateRangesList = camera.supportedViewfinderFrameRateRanges(cameraResolutionList[selectedResolution])
        for( index = 0 ; index < cameraFrameRateRangesList.length ; index++){
            displayText = cameraFrameRateRangesList[index].maximumFrameRate;//cameraFrameRateRangesList[index].minimumFrameRate + "\n" + cameraFrameRateRangesList[index].maximumFrameRate
            cameraFrameRateRangesListModel.append({displayText: displayText})
        }

        cameraSupportedViewfinderFrameRateRangesComboBox.textRole = "displayText"
        cameraSupportedViewfinderFrameRateRangesComboBox.model = cameraFrameRateRangesListModel
        cameraSupportedViewfinderFrameRateRangesComboBox.currentIndex = 0

        ///init

    }

    ListModel {
        id: cameraListModel
    }
    ListModel {
        id: cameraResolutionListModel
    }
    ListModel {
        id: cameraFrameRateRangesListModel
    }

    cameraSupportedViewfinderResolutionsComboBox.onCurrentIndexChanged: {
        //console.log(JSON.stringify(cameraResolutionList[index]))
        print("Resolution")
        var selectedCameraResolutionIndex = cameraSupportedViewfinderResolutionsComboBox.currentIndex
        print("displayText " + cameraResolutionListModel.get(selectedCameraResolutionIndex).displayText)

        camera.stop()
        //camera.viewfinder.maximumFrameRate = 30
        //camera.viewfinder.minimumFrameRate = 30
        camera.viewfinder.resolution = cameraResolutionListModel.get(selectedCameraResolutionIndex).displayText
        camera.start()

        ///////////////
        cameraFrameRateRangesListModel.clear()
        cameraFrameRateRangesList = camera.supportedViewfinderFrameRateRanges(cameraResolutionList[selectedCameraResolutionIndex])
        for(var index = 0 ; index < cameraFrameRateRangesList.length ; index++){
            var displayText = cameraFrameRateRangesList[index].maximumFrameRate;//cameraFrameRateRangesList[index].minimumFrameRate + "\n" + cameraFrameRateRangesList[index].maximumFrameRate
            cameraFrameRateRangesListModel.append({displayText: displayText})
        }

        //cameraSupportedViewfinderFrameRateRangesComboBox.model = cameraFrameRateRangesListModel
    }
    cameraSupportedViewfinderFrameRateRangesComboBox.onCurrentIndexChanged: {
        print("FPS")
        var selectedCameraFrameRateRangesIndex = cameraSupportedViewfinderFrameRateRangesComboBox.currentIndex
        camera.stop()
        camera.viewfinder.maximumFrameRate = cameraFrameRateRangesListModel.get(selectedCameraFrameRateRangesIndex).displayText
        //console.log(camera.viewfinder.maximumFrameRate)
        camera.start()
    }
    cameraListComboBox.onCurrentIndexChanged: {
        print(deviceIdList[cameraListComboBox.currentIndex])
        camera.deviceId = deviceIdList[cameraListComboBox.currentIndex]
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
        cameraSettingWindowMoveAnim.start();
    }


}
