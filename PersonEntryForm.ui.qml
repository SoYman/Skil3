import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

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
    property alias personRelationListView: personRelationListView
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

    YearSpinBox {
        id: bornSpinBox
        x: 8
        y: 54
        from: 0
        value: 1991
        to: 2017
    }

    YearSpinBox {
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

    RelationList {
        id: personRelationListView
        clip: true
        anchors.top: parent.top
        anchors.topMargin: 238
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
