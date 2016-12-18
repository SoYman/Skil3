import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Layouts 1.0
import com.soyman.sqlinterfacemodel 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 900
    minimumWidth: 666
    height: 900
    minimumHeight: 666
    title: qsTr("Computers'n'people")
    Universal.theme: Universal.Light
    onActiveFocusControlChanged: {
        console.log("\nAFC: ", activeFocusControl)

    }
    onActiveFocusItemChanged: {
        console.log("AFI: ", activeFocusItem)
    }



    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        SplitView {
            id: computerView
            activeFocusOnTab: false
            property string relationKeyId

            ComputerEntry {
                id: computerEntry
                Layout.minimumWidth: 333
                computerRelationListView {
                    relationList.model: SqlInterfaceModel {
                        table: "Relations"
                        relationColumn: Number(2)
                        filterType: "computer_id"
                        filter: computerView.relationKeyId
                    }
                    relationList.delegate: computerRelationDelegate
                    relationCandidateList.model: SqlInterfaceModel {
                        table: "People"

                    }
                    relationCandidateList.delegate: computerCandidateDelegate
                }
            }
            Component {
                id: computerRelationDelegate
                ItemDelegate {
                    width: parent.width
                    onClicked: {

                    }
                    //contentItem: Text {
                        text: model.person_id
                    //}
                }
            }

            Component {
                id: computerCandidateDelegate
                ItemDelegate {
                    width: parent.width
                    onClicked: {

                    }
                    text: model.name
                }
            }

            BaseList {
                id: computerPage
                Layout.minimumWidth: 333
                activeFocusOnTab: true

                filterTypeBox {
                    model: ["ID", "Name", "Year", "Type", "Made"]
                }

                filterField.onDisplayTextChanged: {
                    computerPage.baseFilter = filterField.displayText
                }

                list.model: SqlInterfaceModel {
                    id:computerPageModel
                    table: "Computers"
                    filter: computerPage.baseFilter
                    filterType: computerPage.baseFilterType
                    workingRow: computerPage.baseWorkingRow
                }

                list.delegate: computerItemDelegate

                addButton.onClicked: {
                    filterTypeBox.currentIndex = 1
                    list.model.setFilterType(filterTypeBox.currentText)
                    filterTypeBox.currentIndex = 0
                    list.model.setFilterType(filterTypeBox.currentText)
                    baseWorkingRow = 0
                    if (list.model.insertRow(baseWorkingRow)) {
                        list.currentIndex = 0
                        computerEntry.nameTextField.forceActiveFocus()
                    }
                }

            }

            Component {
                id: computerItemDelegate
                ListEntryDelegate {
                    onClicked: {
                        computerPage.list.currentIndex = index
                        //computerView.
                    }


                    onHighlightedChanged: {
                        computerPage.baseWorkingRow = index
                        computerView.relationKeyId = String(model.id)
                        computerEntry.nameTextField.text = model.name
                        computerEntry.yearSpinBox.value = model.year
                        computerEntry.builtCheckBox.checkState = model.made * 2
                        computerEntry.typeTextField.text = model.type
                    }
                    contentItem: Text {
                        text: model.name
                    }
                }
            }
        }

        SplitView {
            id: personView
            activeFocusOnTab: false
            property int personRelationColumn: 1
            property string relationKeyId

            PersonEntry {
                id: personEntry
                Layout.minimumWidth: 333
                personRelationListView {
                    relationList.model: SqlInterfaceModel {
                        table: "Relations"
                        relationColumn: Number(1)
                        filterType: "person_id"
                        filter: personView.relationKeyId
                    }
                    relationList.delegate: personRelationDelegate
                    relationCandidateList.model: SqlInterfaceModel {

                    }
                }
            }
            Component {
                id: personRelationDelegate
                ItemDelegate {
                    width: parent.width
                    onClicked: {

                    }
                    //contentItem: Text {
                        text: model.computer_id
                    //}
                }
            }
            BaseList {
                id: peoplePage
                Layout.minimumWidth: 333

                filterTypeBox {
                    model: ["ID", "Name", "Born", "Died", "Gender", "Nationality"]
                }

                filterField.onDisplayTextChanged: {
                    baseFilter = filterField.displayText
                }

                list.model: SqlInterfaceModel {
                    table: "People"
                    filter: peoplePage.baseFilter
                    filterType: peoplePage.baseFilterType
                    workingRow: peoplePage.baseWorkingRow
                }

                list.delegate: peopleItemDelegate

                addButton.onClicked: {
                    filterTypeBox.currentIndex = 1
                    list.model.setFilterType(filterTypeBox.currentText)
                    filterTypeBox.currentIndex = 0
                    list.model.setFilterType(filterTypeBox.currentText)
                    baseWorkingRow = 0
                    if (list.model.insertRow(baseWorkingRow)) {
                        list.currentIndex = 0
                        list.model.setValue("born", 0)
                        list.model.setValue("died", 0)
                        list.model.setValue("gender", "Unspecified")
                        personEntry.genderButtonState = "Unspecified"
                        personEntry.nameTextField.forceActiveFocus()
                    }
                }
            }

            Component {
                id: peopleItemDelegate
                ListEntryDelegate {
                    onClicked: {
                        peoplePage.list.currentIndex = index
                    }

                    onHighlightedChanged: {
                        peoplePage.baseWorkingRow = index
                        personView.relationKeyId = String(model.id)
                        personEntry.nameTextField.text = model.name
                        personEntry.bornSpinBox.value = model.born
                        // This was easy to make:
                        personEntry.diedSpinBox.from = 0
                        personEntry.diedSpinBox.enabled = model.born <= model.died
                        personEntry.diedSpinBox.value = model.died
                        personEntry.diedSpinBox.from = model.born > model.died ? 0 : model.born
                        personEntry.aliveCheckBox.checkState = model.born > model.died ? 2 : 0
                        personEntry.genderButtonState = model.gender
                        personEntry.nationalityTextField.text = model.nationality
                    }
                    contentItem: Text {
                        text: model.name
                    }
                }
            }
        }
    }

    footer: TabBar {
        id: tabBar
        topPadding: 1
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Computers")
        }
        TabButton {
            text: qsTr("People")
        }
//        TabButton {
//            text: qsTr("Relations")
//        }
    }
}
