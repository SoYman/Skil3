import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    id: computerEntryForm
    width: 400
    height: 400
    property alias removeButton: removeButton

    TextField {
        id: nameTextField
        placeholderText: qsTr("Name")
        anchors.bottom: parent.top
        anchors.bottomMargin: -48
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 8
    }

    SpinBox {
        id: yearSpinBox
        anchors.bottom: parent.top
        anchors.bottomMargin: -94
        anchors.right: parent.left
        anchors.rightMargin: -148
        anchors.top: parent.top
        anchors.topMargin: 54
        anchors.left: parent.left
        anchors.leftMargin: 8
        enabled: true
        to: 2017
        value: 1991
    }


    Label {
        id: label1
        text: qsTr("Year designed")
        anchors.right: parent.left
        anchors.rightMargin: -234
        anchors.bottom: parent.top
        anchors.bottomMargin: -83
        anchors.top: parent.top
        anchors.topMargin: 66
        anchors.left: parent.left
        anchors.leftMargin: 154
    }

    CheckBox {
        id: builtCheckBox
        text: qsTr("Built")
        anchors.left: parent.right
        anchors.leftMargin: -81
        anchors.bottom: parent.top
        anchors.bottomMargin: -94
        anchors.top: parent.top
        anchors.topMargin: 54
        anchors.right: parent.right
        anchors.rightMargin: 8
    }

    TextField {
        id: typeTextField
        placeholderText: qsTr("Type of computer")
        anchors.bottom: parent.top
        anchors.bottomMargin: -140
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
    }

    ListView {
        id: relationListView
        anchors.top: parent.top
        anchors.topMargin: 146
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 54
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                spacing: 10
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                }

                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
            }
        }
        model: ListModel {
            ListElement {
                name: "Grey"
                colorCode: "grey"
            }

            ListElement {
                name: "Red"
                colorCode: "red"
            }

            ListElement {
                name: "Blue"
                colorCode: "blue"
            }

            ListElement {
                name: "Green"
                colorCode: "green"
            }
        }
    }

    Button {
        id: removeButton
        text: qsTr("Remove")
        anchors.top: parent.bottom
        anchors.topMargin: -48
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
    }
}
