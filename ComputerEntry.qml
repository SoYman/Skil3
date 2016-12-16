import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

ComputerEntryForm {

//    removeButton.contentItem: Text {
//        text: qsTr("Remove")
//        horizontalAlignment: Text.AlignHCenter
//        verticalAlignment: Text.AlignVCenter
//    }

    removeButton.background: Rectangle {
        border.color: Universal.color(Universal.Red)
        border.width: 5
        radius: 5
        color: removeButton.down ? Universal.color(Universal.Red) : Universal.foreground

    }
}
