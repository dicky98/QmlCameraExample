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
