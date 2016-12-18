import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Layouts 1.0

Item {
    id: baseList
    Layout.fillWidth: true
    property alias filterField: filterField
    property alias filterTypeBox: filterTypeBox
    property alias list: list
    property alias addButton: addButton

    property string baseFilter
    property string baseFilterType: "Name"
    property int baseWorkingRow: -1

    TextField {
        id: filterField
        y: 8
        height: 40
        anchors.right: parent.right
        anchors.rightMargin: 164
        anchors.left: parent.left
        anchors.leftMargin: 8
        placeholderText: qsTr("Filter")
    }

    ComboBox {
        id: filterTypeBox
        y: 8
        height: 40
        anchors.left: parent.right
        anchors.leftMargin: -158
        anchors.right: parent.right
        anchors.rightMargin: 8
        currentIndex: 1
        delegate: ItemDelegate {
            width: filterTypeBox.width
            highlighted: filterTypeBox.highlightedIndex == index
            text: modelData
            onClicked: {
                filterTypeBox.currentIndex = index
                list.model.setFilterType(filterTypeBox.currentText)
            }
        }
    }

    ListView {
        id: list
        clip: true
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 54
        anchors.top: parent.top
        anchors.topMargin: 54
        currentIndex: -1
        highlightFollowsCurrentItem: true
    }

    Button {
        id: addButton
        text: qsTr("Add entry")
        rightPadding: 11
        anchors.top: parent.bottom
        anchors.topMargin: -48
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8

        background: Rectangle {
            border.color: Universal.color(Universal.Emerald)
            border.width: 4
            radius: 4
            color: addButton.down ? Universal.color(Universal.Emerald) : Universal.background
        }
    }
}
