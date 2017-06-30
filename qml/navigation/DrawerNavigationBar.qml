// ekke (Ekkehard Gentz) @ekkescorner
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "../common"

Drawer {
    id: myBar
    z: 1
    leftPadding: 0
    property alias navigationButtons: navigationButtonRepeater
    property real activeOpacity: iconFolder == "black" ?  0.87 : 1.0
    property real inactiveOpacity: iconFolder == "black" ?  0.56 : 0.87 //  0.26 : 0.56
    width: appWindow.backKeyfreezed || appWindow.modalPopupActive? 0 : (Math.min(240,  Math.min(appWindow.width, appWindow.height) / 3 * 2 ) )
    height: appWindow.height

    // BUG in Qt 5.9: tap outside Drawer doesn't close always
    // but allows clicking on Buttons below
    // see https://bugreports.qt.io/browse/QTBUG-61581
    // workaround: 'insert' anotherfake Popup to block unwanted clicks
    onOpened: {
        fakePopup.open()
    }
    onAboutToHide: {
        fakePopup.close()
    }
    Popup {
        id: fakePopup
        z: 0
        width: appWindow.width
        height: appWindow.height
    }
    // end workaround QTBUG-61581

    Flickable {
        contentHeight: myButtons.height
        anchors.fill: parent
        clip: true

        ColumnLayout {
            id: myButtons
            focus: false
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0
            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 90 // 120
                Rectangle {
                    anchors.fill: parent
                    color: primaryColor
                }
                Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: 42 // 56
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 16
                        rightPadding: 16
                        LabelBody {
                            text: "Bluetooth LE\nExample"
                            wrapMode: Text.WordWrap
                            font.weight: Font.Medium
                            color: textOnPrimary
                        }
                    }
                }
                Item {
                    // space between content - see google material guide
                    height: 8
                }
                Item {
                    width: 64
                    height: 64
                    x: 16
                    y: 12
                    IconOnPrimary {
                        imageName: "signal.png"
                        imageSize: 36
                    }
                }
                Item {
                    width: 64
                    height: 64
                    x: 16+64
                    y: 16
                    IconOnPrimary {
                        imageName: "bluetooth.png"
                        imageSize: 36
                    }
                }
                Item {
                    width: 64
                    height: 64
                    x: 16+64+64
                    y: 12
                    IconOnPrimary {
                        imageName: "chart.png"
                        imageSize: 36
                    }
                }
            }
            Item {
                // space between content - see google material guide
                height: 8
            }
            Repeater {
                id: navigationButtonRepeater
                model: navigationModel
                Loader {
                    Layout.fillWidth: true
                    source: modelData.type
                    active: true
                }
            } // repeater
            //
        } // ColumnLayout myButtons
        ScrollIndicator.vertical: ScrollIndicator { }

    } // Flickable

    function replaceIcon(position, theIconName) {
        navigationButtonRepeater.itemAt(position).item.theIcon = theIconName
    }
    function replaceText(position, theText) {
        navigationButtonRepeater.itemAt(position).item.theText = theText
    }

} // drawer
