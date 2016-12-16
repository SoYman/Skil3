import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Layouts 1.0
import com.soyman.sqlcomputermodel 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Computers'n'people")
    Universal.theme: Universal.Dark

    property string computerFilter
    property string computerFilterType


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        SplitView {

            ComputerEntry {
                removeButton.onReleased: {
}
                Layout.minimumWidth: 333
            }

            BaseList {
                id: computerPage
                Layout.fillWidth: true

                    filterField.onAccepted: {
                        computerFilter = filterField.displayText
                    }

                filterTypeBox.model: ["Name", "Year", "Type", "Made", "ID"]

                list {
                    model: SqlComputerModel {
                        filter: computerFilter
                        filterType: computerFilterType

                    }

                    delegate: ItemDelegate {
                        width: parent.width

                        text: model.name
                        onClicked: {

                        }
                    }
                }
            }
        }

/*
        PageForm {
            filterTypeBox.onDisplayTextChanged: {
            }
            filterTypeBox.model: ["Nmae", "Born", "Died", "Gender", "Nationality"]
            list.delegate: CheckDelegate {
                id: control
                text: qsTr("CheckDelegate")
                checked: true

                contentItem: Text {
                    rightPadding: control.indicator.width + control.spacing
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: control.down ? "#17a81a" : "#21be2b"
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }

                indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: control.width - width - control.rightPadding
                    y: control.topPadding + control.availableHeight / 2 - height / 2
                    radius: 3
                    color: "transparent"
                    border.color: control.down ? "#17a81a" : "#21be2b"

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 2
                        color: control.down ? "#17a81a" : "#21be2b"
                        visible: control.checked
                    }
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    visible: control.down || control.highlighted
                    color: control.down ? "#bdbebf" : "#eeeeee"
                }
            }
            list.model: ListModel {
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

        PageForm {
            list.delegate: Item {
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
            list.model: ListModel {
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
        }*/
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Computers")
        }
        TabButton {
            text: qsTr("People")
        }
        TabButton {
            text: qsTr("Relations")
        }
    }
}
