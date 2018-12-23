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
        //camera: camera
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
