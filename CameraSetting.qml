import QtQuick 2.4
import QtMultimedia 5.8

CameraSettingForm {
    property bool bShowMenu: false
    property var cameraResolutionList: []
    property var cameraFrameRateRangesList: []
    property int selectedCameraResolutionIndex: -1
    property int selectedCameraFrameRateRangesIndex: -1
    //property list cameraFrameRateRangesList: camera.supportedViewfinderFrameRateRanges()

    Component.onCompleted: {
        cameraResolutionList = camera.supportedViewfinderResolutions()
        cameraSupportedViewfinderResolutionsComboBox.model = cameraResolutionList
        cameraSupportedViewfinderFrameRateRangesComboBox.model = cameraFrameRateRangesList
    }

    cameraSupportedViewfinderResolutionsComboBox.delegate: Item {
            property var displayText : cameraResolutionList[index].width + "x" + cameraResolutionList[index].height
            width: parent.width
            height: 30
            Text {
                text: displayText
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    //console.log(JSON.stringify(cameraResolutionList[index]))
                    cameraSupportedViewfinderResolutionsComboBox.currentIndex = index
                    cameraSupportedViewfinderResolutionsComboBox.displayText = displayText
                    selectedCameraResolutionIndex = index
                    cameraFrameRateRangesList = camera.supportedViewfinderFrameRateRanges(cameraResolutionList[selectedCameraResolutionIndex])
                    cameraSupportedViewfinderFrameRateRangesComboBox.model = cameraFrameRateRangesList

                    camera.stop()
                    //camera.viewfinder.maximumFrameRate = 30
                    //camera.viewfinder.minimumFrameRate = 30
                    camera.viewfinder.resolution = displayText
                    camera.start()
                    cameraSupportedViewfinderResolutionsComboBox.popup.close()
                }
            }
    }
    cameraSupportedViewfinderFrameRateRangesComboBox.delegate: Item {
        property var displayText : cameraFrameRateRangesList[index].minimumFrameRate + "\n" + cameraFrameRateRangesList[index].maximumFrameRate
            width: parent.width
            height: 30
            Text {
                text: displayText
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(JSON.stringify(cameraFrameRateRangesList[index]))
                    cameraSupportedViewfinderFrameRateRangesComboBox.currentIndex = index
                    cameraSupportedViewfinderFrameRateRangesComboBox.displayText = displayText
                    selectedCameraFrameRateRangesIndex = index

                    cameraSupportedViewfinderFrameRateRangesComboBox.popup.close()
                }
            }
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

    cameraListComboBox.delegate: Item {
        width: parent.width
        height: 30
        Text {
            text: modelData.displayName

            anchors.fill: parent
            anchors.margins: 5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            color: "black"
            font.bold: true
            style: Text.Raised
            styleColor: "black"
            font.pixelSize: 14
        }
        MouseArea {
            id: cameraListMouseArea
            anchors.fill: parent
            onClicked: {
                //console.log(index)
                //console.log(modelData.deviceId)
                //console.log(camera.deviceId)
                camera.deviceId = modelData.deviceId
                cameraListComboBox.currentIndex = index
                cameraListComboBox.displayText = modelData.displayName
                cameraListComboBox.popup.close()
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
