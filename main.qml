import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Layouts 1.0
import com.soyman.sqlcomputermodel 1.0
import com.soyman.sqlinterfacemodel 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 900
    minimumWidth: 666
    height: 900
    minimumHeight: 666
    title: qsTr("Computers'n'people")
    Universal.theme: Universal.Dark



    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        SplitView {
            id: computerView
            property int computerWorkingRow: -1

            ComputerEntry {
                id: computerEntry
                nameTextField.onDisplayTextChanged: {
                    computerPage.list.model.setValue("name", nameTextField.displayText)
                }
                yearSpinBox.onValueChanged: {
                    computerPage.list.model.setValue("year", yearSpinBox.value)
                }
                builtCheckBox.onCheckStateChanged: {
                    computerPage.list.model.setValue("made", builtCheckBox.checkState / 2)
                }
                typeTextField.onDisplayTextChanged: {
                    computerPage.list.model.setValue("type", typeTextField.displayText)

                }

                removeButton.onReleased: {
                }
                Layout.minimumWidth: 333
            }

            BaseList {
                id: computerPage
                Layout.fillWidth: true
                property string computerFilter
                property string computerFilterType

                filterTypeBox {
                    model: ["Name", "Year", "Type", "Made", "ID"]
                    onDisplayTextChanged: {
                        computerPage.computerFilterType = filterTypeBox.currentText
                    }
                }

                filterField.onAccepted: {
                    computerPage.computerFilter = filterField.displayText
                }

                list {
                    model: SqlInterfaceModel {
                        table: "Computers"
                        filter: computerPage.computerFilter
                        filterType: computerPage.computerFilterType
                        workingRow: computerView.computerWorkingRow
                    }

                    delegate: ItemDelegate {
                        width: parent.width

                        text: model.name
                        // Display computer in sidebar
                        onClicked: {
                            computerView.computerWorkingRow = model.row
                            computerEntry.nameTextField.text = model.name
                            computerEntry.yearSpinBox.value = model.year
                            computerEntry.builtCheckBox.checkState = model.made*2
                            computerEntry.typeTextField.text = model.type
                        }
                    }
                }
            }
        }

        SplitView {

            PersonEntry {
                id: personEntry
                nameTextField.onDisplayTextChanged: {
                    peoplePage.list.model.setValue("name", nameTextField.displayText)
                }


                removeButton.onReleased: {
                }
                Layout.minimumWidth: 333
            }

            BaseList {
                id: peoplePage
                Layout.fillWidth: true
                property string peopleFilter
                property string peopleFilterType
                property int peopleWorkingRow: -1

                filterTypeBox {
                    model: ["Name", "Born", "Died", "Gender", "Nationality"]
                    onDisplayTextChanged: {
                        peopleFilterType = filterTypeBox.currentText
                    }
                }

                filterField.onAccepted: {
                    peopleFilter = filterField.displayText
                }

                list {
                    model: SqlInterfaceModel {
                        table: "People"
                        filter: peoplePage.peopleFilter
                        filterType: peoplePage.peopleFilterType
                        workingRow: peoplePage.peopleWorkingRow

                    }

                    delegate: ItemDelegate {
                        width: parent.width

                        text: model.name
                        // Display person in sidebar
                        onClicked: {
                            console.log(model.row)
                            peoplePage.peopleWorkingRow = model.row
                            personEntry.nameTextField.text = model.name
                            personEntry.bornSpinBox.value = model.born
                            personEntry.diedSpinBox.from = model.died >= model.born ? model.born : 0
                            personEntry.diedSpinBox.value = model.died
                            personEntry.diedSpinBox.enabled = model.died >= model.born
                            personEntry.aliveCheckBox.checkState = Number(model.died < model.born) * 2
                            personEntry.genderButtonState = model.gender
                            personEntry.nationalityTextField.text = model.nationality
                        }
                    }
                }
            }
        }
/*
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
