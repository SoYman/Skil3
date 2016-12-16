import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

PersonEntryForm {
    //property alias genderButtonGroup: genderButtonGroup
    property string genderButtonState: "Unspecified"

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
//            background: Rectangle {
//                implicitWidth: 100
//                implicitHeight: 40
//                visible: genderRadioDelegate.down || genderRadioDelegate.highlighted
//                color: genderRadioDelegate.down ? "#bdbebf" : "#eeeeee"
//            }
        }
    }

    removeButton.background: Rectangle {
        border.color: Universal.color(Universal.Red)
        border.width: 5
        radius: 5
        color: removeButton.down ? Universal.color(Universal.Red) : Universal.foreground
    }
}
