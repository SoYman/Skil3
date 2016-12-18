import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

PersonEntryForm {
    property string genderButtonState: "Unspecified"
    nameTextField.onDisplayTextChanged: {
        peoplePage.list.model.setValue("name", nameTextField.displayText)
    }
    bornSpinBox.onValueChanged: {
        peoplePage.list.model.setValue("born", bornSpinBox.value)
    }
    diedSpinBox.onValueChanged: {
        peoplePage.list.model.setValue("died", diedSpinBox.value)
    }
    aliveCheckBox.onCheckStateChanged: {
        if (aliveCheckBox.checkState == 2) {
            peoplePage.list.model.setValue("died", 0)
            diedSpinBox.enabled = false
        } else {
            peoplePage.list.model.setValue("died", diedSpinBox.value)
            diedSpinBox.enabled = true
        }
    }/*
    genderListView: {
        console.log("gender changed")
        peoplePage.list.model.setValue("gender", genderButtonState)
    }*/
    nationalityTextField.onDisplayTextChanged: {
        peoplePage.list.model.setValue("nationality", nationalityTextField.displayText)
    }
    removeButton.onReleased: {
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
