import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlsStyles
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./drawable"

/// Base Button Component

Controls.Button {

    id: button

    property ButtonStyle aStyle: ThemeManager.currentTheme.button

    property size iconSourceSize : aStyle.iconSourceSize

    property var background : aStyle.background

    property color textColor: aStyle.textStyle.textColor

    /// The text size in sp unit
    property int textSize: aStyle.textStyle.textSize

    /// Specifies that icon and background on the local filesystem should be loaded asynchronously in a separate thread. The default value is false, causing the user interface thread to block while the it is loading.
    property bool asynchronous : aStyle.asynchronous

    style: ControlsStyles.ButtonStyle {

        padding.left: 0
        padding.right: 0
        padding.top: 0
        padding.bottom: 0

        background: StateListDrawable {
            // Ignore the fill area @ Material Design
            implicitHeight: 36 * A.dp
            implicitWidth: 36 * A.dp
            source: control.background
            pressed: control.pressed
            asynchronous: control.asynchronous
        }

        label: Item {
            id: item
            implicitWidth: Math.max(36 * A.dp, label.width + 32 * A.dp);
            implicitHeight: 36 * A.dp
            anchors.centerIn: parent

            Image {
                id: icon
                source: control.iconSource
                sourceSize: control.iconSourceSize
                visible: control.iconSource !== null
                anchors.centerIn: parent
                asynchronous: control.asynchronous
            }

            Text {
                id: label
                anchors.centerIn: parent
                text: control.text
                textStyle: TextStyle {
                    textColor: button.textColor
                    textSize: button.textSize
                    bold: button.aStyle.textStyle.bold
                }
            }

            states: [
                State {
                    name: "IconOnly"
                    when: String(control.iconSource).length !== 0 && control.text.length === 0

                    PropertyChanges {
                        target: item
                        implicitWidth: 48 * A.dp
                        implicitHeight: 48 * A.dp
                    }
                },

                State {
                    name: "IconAndText"
                    when: String(control.iconSource).length !== 0 && control.text.length !== 0

                    PropertyChanges {
                        target: icon
                        anchors.centerIn: undefined
                        anchors.verticalCenter: item.verticalCenter
                        anchors.left: item.left
                        anchors.leftMargin: 8 * A.dp
                    }

                    PropertyChanges {
                        target: label
                        anchors.centerIn: undefined
                        anchors.verticalCenter: item.verticalCenter
                        anchors.right: item.right
                        anchors.rightMargin: 8 * A.dp
                    }

                    PropertyChanges {
                        target: item
                        implicitWidth: Math.max(36 * A.dp, icon.width + label.width + 16 * A.dp);
                        implicitHeight: 48 * A.dp
                    }
                }

            ]
        }
    }
}
