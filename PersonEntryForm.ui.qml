import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    id: item1
    width: 400
    height: 800
    property alias nameTextField: nameTextField
    property alias bornSpinBox: bornSpinBox
    property alias diedSpinBox: diedSpinBox
    property alias aliveCheckBox: aliveCheckBox
    property alias genderListView: genderListView
    property alias nationalityTextField: nationalityTextField
    property alias relationListView: relationListView
    property alias removeButton: removeButton

    TextField {
        id: nameTextField
        placeholderText: qsTr("Name")
        anchors.bottom: parent.top
        anchors.bottomMargin: -48
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
    }

    SpinBox {
        id: bornSpinBox
        x: 8
        y: 54
        from: 0
        value: 1991
        to: 2017
    }

    SpinBox {
        id: diedSpinBox
        x: 8
        y: 100
        from: 0
        value: 0
        to: 2017
    }

    CheckBox {
        id: aliveCheckBox
        text: qsTr("Alive")
        clip: true
        checked: true
        anchors.right: parent.left
        anchors.rightMargin: -81
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.top
        anchors.bottomMargin: -186
        anchors.top: parent.top
        anchors.topMargin: 146
    }

    TextField {
        id: nationalityTextField
        placeholderText: qsTr("Nationality")
        anchors.top: parent.top
        anchors.topMargin: 192
        anchors.bottom: parent.top
        anchors.bottomMargin: -232
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
    }

    ListView {
        id: genderListView
        anchors.top: parent.top
        anchors.topMargin: 54
        anchors.bottom: parent.top
        anchors.bottomMargin: -186
        anchors.left: parent.right
        anchors.leftMargin: -138
        anchors.right: parent.right
        anchors.rightMargin: 8
        interactive: false
    }

    ListView {
        id: relationListView
        clip: true
        anchors.top: parent.top
        anchors.topMargin: 238
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
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
    }


    Label {
        id: bornLabel
        x: 154
        y: 66
        text: qsTr("Born")
    }

    Label {
        id: diedLabel
        x: 154
        y: 112
        text: qsTr("Died")
    }
}
