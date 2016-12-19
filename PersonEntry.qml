import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

PersonEntryForm {
    property string genderButtonState: "Unspecified"
    property int previousDeath: 0
    nameTextField.onDisplayTextChanged: {
        if (nameTextField.activeFocus) {
            peoplePage.list.model.setValue("name", nameTextField.displayText)
        }
    }

    bornSpinBox.onValueChanged: {
        if (bornSpinBox.activeFocus) {
            peoplePage.list.model.setValue("born", bornSpinBox.value)
            diedSpinBox.from = aliveCheckBox.checkState == 2 ? 0 : bornSpinBox.value
        }
    }

    diedSpinBox.onValueChanged: {
        if (diedSpinBox.activeFocus) {
            peoplePage.list.model.setValue("died", diedSpinBox.value)
        }
    }

    aliveCheckBox.onClicked: {
        if (aliveCheckBox.activeFocus) {
            if (aliveCheckBox.checkState == 2) {
                console.log("died now: ", 0)
                diedSpinBox.from = 0
                diedSpinBox.value = 0
                diedSpinBox.enabled = false
                peoplePage.list.model.setValue("died", 0)
            } else {
                console.log("died then: ", diedSpinBox.value)
                diedSpinBox.enabled = true
                diedSpinBox.from = bornSpinBox.value
                diedSpinBox.value = 2017
                peoplePage.list.model.setValue("died", diedSpinBox.value)
            }
        }
    }

    nationalityTextField.onDisplayTextChanged: {
        if (nationalityTextField.activeFocus) {
        peoplePage.list.model.setValue("nationality", nationalityTextField.displayText)
        }
    }

    removeButton.onReleased: {
        peoplePage.list.model.removeWorkingRow()
        if (peoplePage.list.count == peoplePage.baseWorkingRow) {
            peoplePage.list.decrementCurrentIndex()
        }
    }

    bornSpinBox {
        editable: true
    }

    diedSpinBox {
        editable: true
    }

    genderListView {
        model: [ "Unspecified", "Female", "Male" ]
        //highlightFollowsCurrentItem: true
        delegate: RadioDelegate {
            id: genderRadioDelegate
            checked: modelData == genderButtonState
            activeFocusOnTab: true

            // This refused to work outside of the RadioDelegate scope
            onClicked: {
                genderButtonState = modelData
                peoplePage.list.model.setValue("gender", genderButtonState)
            }

            onActiveFocusChanged: {
                highlighted = activeFocus
            }

            contentItem: Text {
                leftPadding: genderRadioDelegate.indicator.width + genderRadioDelegate.spacing
                text: modelData
                color: Universal.foreground
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            indicator: Item {
                implicitWidth: 20
                implicitHeight: 20
                x: parent.height / 2 - height / 2
                y: parent.height / 2 - height / 2
                Rectangle {
                    anchors.fill: parent
                    radius: 10
                    color: Universal.color(Universal.Indigo)
                    opacity: genderRadioDelegate.highlighted ? 0.15 : 0
                }
                Rectangle {
                    anchors.fill: parent
                    radius: 10
                    color: "transparent"
                    border.color: genderRadioDelegate.highlighted ? Universal.color(Universal.Indigo) : Universal.foreground
                }
                Rectangle {
                    width: 10
                    height: 10
                    x: 5
                    y: 5
                    radius: 5
                    color: Universal.foreground
                    visible: genderRadioDelegate.checked
                }
            }

            background: Rectangle {
                implicitWidth: 130
                implicitHeight: 44
                visible: genderRadioDelegate.down
                color: "#bdbebf"
            }
        }
    }

    removeButton.background: Rectangle {

        border.color: Universal.color(Universal.Red)
        border.width: 4
        radius: 4
        // This really wants to swap the BG with the FG
        color: removeButton.down ? Universal.color(Universal.Red) : Universal.background
    }
}
