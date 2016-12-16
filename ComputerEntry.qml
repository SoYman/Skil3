import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

ComputerEntryForm {
    typeTextField.onAccepted: {
}
    relationListView.onActiveFocusChanged: {
    }
    builtCheckBox.onCanceled: {
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
