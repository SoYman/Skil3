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
        console.log("A")
        if (diedSpinBox.activeFocus) {
            console.log("B")
            peoplePage.list.model.setValue("died", diedSpinBox.value)
        }
    }
    aliveCheckBox.onClicked: {
        if (aliveCheckBox.activeFocus) {
            console.log("Alive changed! ", aliveCheckBox.checkState)
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
        console.log("REMOVE")
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

        delegate: RadioDelegate {
            id: genderRadioDelegate
            checked: modelData == genderButtonState

            // This refused to work outside of the RadioDelegate scope
            onClicked: {
                genderButtonState = modelData
                peoplePage.list.model.setValue("gender", genderButtonState)
            }

            contentItem: Text {
                leftPadding: genderRadioDelegate.indicator.width + genderRadioDelegate.spacing
                text: modelData
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            indicator: Rectangle {
                implicitWidth: 20
                implicitHeight: 20
                x: parent.height / 2 - height / 2
                y: parent.height / 2 - height / 2
                radius: 10
                color: "transparent"
                border.color: Universal.background
                Rectangle {
                    width: 10
                    height: 10
                    x: 5
                    y: 5
                    radius: 5
                    color: Universal.background
                    visible: genderRadioDelegate.checked
                }
            }
        }
    }

    removeButton.background: Rectangle {
        border.color: Universal.color(Universal.Red)
        border.width: 5
        radius: 5
        color: removeButton.down ? Universal.color(Universal.Red) : Universal.foreground
    }
}
