import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    id: computerEntryForm
    width: 400
    height: 400
    property alias typeTextField: typeTextField
    property alias builtCheckBox: builtCheckBox
    property alias yearSpinBox: yearSpinBox
    property alias nameTextField: nameTextField
    property alias computerRelationListView: computerRelationListView
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

    YearSpinBox {
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
        id: yearLabel
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
        clip: true
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

//    BaseList {
//        id: relationListView
//        clip: true
//        anchors.top: parent.top
//        anchors.topMargin: 146
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 54
//        anchors.left: parent.left
//        anchors.leftMargin: 8
//        anchors.right: parent.right
//        anchors.rightMargin: 8
//    }

    RelationList {
        id: computerRelationListView
        anchors.top: parent.top
        anchors.topMargin: 146
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 54
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
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
