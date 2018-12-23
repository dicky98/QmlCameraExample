import QtQuick 2.4
import QtQuick.Controls 1.5
import QtMultimedia 5.6
import QtQuick.Layouts 1.3

Item {
    id: cameraSettingItem
    property string cameraResolution
    property alias cameraSettingWindow: cameraSettingWindow
    property alias cameraListComboBox: cameraListComboBox
    property alias cameraSupportedViewfinderResolutionsComboBox: cameraSupportedViewfinderResolutionsComboBox
    property alias cameraSupportedViewfinderFrameRateRangesComboBox: cameraSupportedViewfinderFrameRateRangesComboBox
    property alias cameraViewRotateSettingComboBox: cameraViewRotateSettingComboBox

    property point moveFrom
    property point moveTo

    Rectangle {
        id: cameraSettingWindow
        visible: false
        //opacity: 0.5
        width: parent.width
        height: parent.height
        color: "white"

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width/2
            Text {
                id: planetText
                //anchors.bottom: parent.bottom
                //anchors.topMargin: 20

                font.family: "Helvetica"
                font.pixelSize: 32
                font.weight: Font.Light
                color: "white"

                text: "<p>" + "Setting!" + "</p>"
                transformOrigin: Item.Center
            }
            RowLayout {
                Text {
                    //anchors.bottom: parent.bottom
                    //anchors.topMargin: 20

                    //font.family: "Helvetica"
                    //font.pixelSize: 32
                    //font.weight: Font.Light
                    //color: "white"

                    text: "Camera:          "
                    transformOrigin: Item.Center
                }
                ComboBox {
                    id: cameraListComboBox
                    Layout.fillWidth: true
                    //anchors.horizontalCenter: parent.horizontalCenter
                    currentIndex: 0
                }
            }

            RowLayout {
                Text {
                    text: "Resoultion:     "
                }
                ComboBox {
                    id: cameraSupportedViewfinderResolutionsComboBox
                    Layout.fillWidth: true
                    currentIndex: -1
                }
            }

            RowLayout {
                Text {
                    text: "Rotate Image: "
                }
                ComboBox {
                    id: cameraViewRotateSettingComboBox
                    Layout.fillWidth: true
                    currentIndex: -1
                }
            }

            RowLayout {
                Text {
                    text: "Video Fps:      "
                }
                ComboBox {
                    id: cameraSupportedViewfinderFrameRateRangesComboBox
                    Layout.fillWidth: true
                    currentIndex: -1
                }
            }

        }
    }
}
