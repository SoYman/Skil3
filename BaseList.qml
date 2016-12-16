import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Item {
    id: baseList
    property alias filterField: filterField
    property alias filterTypeBox: filterTypeBox
    property alias list: list

    TextField {
        id: filterField
        y: 8
        height: 40
        anchors.right: parent.right
        anchors.rightMargin: 164
        anchors.left: parent.left
        anchors.leftMargin: 8
        placeholderText: qsTr("Text Field")
    }

    ComboBox {
        id: filterTypeBox
        y: 8
        height: 40
        anchors.left: parent.right
        anchors.leftMargin: -158
        anchors.right: parent.right
        anchors.rightMargin: 8
    }

    ListView {
        id: list
        clip: true
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 54
    }
}
