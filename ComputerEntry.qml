import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

ComputerEntryForm {

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
    typeTextField.onAccepted: {
    }
    relationListView.onActiveFocusChanged: {
    }
    yearSpinBox {
        editable: true
    }

    removeButton.background: Rectangle {
        border.color: Universal.color(Universal.Red)
        border.width: 5
        radius: 5
        color: removeButton.down ? Universal.color(Universal.Red) : Universal.foreground

    }
}
