import QtQuick 2.4
import QtQuick.Controls 2.0
import QtMultimedia 5.8
import QtQuick.Layouts 1.3

Item {
    id: cameraSettingItem
    property Camera camera
    property alias cameraSettingWindow: cameraSettingWindow
    property alias cameraListComboBox: cameraListComboBox
    property alias cameraSupportedViewfinderResolutionsComboBox: cameraSupportedViewfinderResolutionsComboBox
    property alias cameraSupportedViewfinderFrameRateRangesComboBox: cameraSupportedViewfinderFrameRateRangesComboBox

    property point moveFrom
    property point moveTo

    Rectangle {
        id: cameraSettingWindow
        visible: false
        opacity: 0.5
        width: parent.width
        height: parent.height
        color: "white"

        ColumnLayout {
            width: parent.width
            Text {
                id: planetText
                //anchors.bottom: parent.bottom
                //anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter

                font.family: "Helvetica"
                font.pixelSize: 32
                font.weight: Font.Light
                color: "white"

                text: "<p>" + "Setting!" + "</p>"
                transformOrigin: Item.Center
            }
            ComboBox {
                id: cameraListComboBox
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                model: QtMultimedia.availableCameras
                currentIndex: 0

                //onCurrentIndexChanged: {}
            }

            ComboBox {
                id: cameraSupportedViewfinderResolutionsComboBox
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                currentIndex: 0
            }

            ComboBox {
                id: cameraSupportedViewfinderFrameRateRangesComboBox
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                currentIndex: 0
            }
        }
    }
}
