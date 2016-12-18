import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

ComputerEntryForm {
    Universal.theme: Universal.Light

    nameTextField.onDisplayTextChanged: {
        if (nameTextField.activeFocus) {
            computerPage.list.model.setValue("name", nameTextField.displayText)
        }
    }

    yearSpinBox.onValueChanged: {
        if (yearSpinBox.activeFocus) {
            computerPage.list.model.setValue("year", yearSpinBox.value)
        }
    }

    builtCheckBox.onCheckStateChanged: {
        if (builtCheckBox.activeFocus) {
            computerPage.list.model.setValue("made", builtCheckBox.checkState / 2)
        }
    }
    typeTextField.onDisplayTextChanged: {
        if (typeTextField.activeFocus) {
            computerPage.list.model.setValue("type", typeTextField.displayText)
        }
    }

    removeButton.onReleased: {
        console.log("REMOVE")
        computerPage.list.model.removeWorkingRow()
        if (computerPage.list.count == computerPage.baseWorkingRow) {
            computerPage.list.decrementCurrentIndex()
        }
    }

    yearSpinBox {
        editable: true
    }

    removeButton.background: Rectangle {
        border.color: Universal.color(Universal.Red)
        border.width: 4
        radius: 4
        // This really wants to swap the BG with the FG
        color: removeButton.down ? Universal.color(Universal.Red) : Universal.background
    }
}
