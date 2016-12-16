import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0

PersonEntryForm {
    bornSpinBox {
        editable: true
    }
    diedSpinBox {
        editable: true
    }

    ButtonGroup {
        id: genderButtonGroup
    }

    genderListView {
        model: ["Male", "Female", "Unspecified"]
        delegate: RadioDelegate {
            id: genderRadioDelegate
            checked: index == 0
            ButtonGroup.group: genderButtonGroup

            contentItem: Text {
                leftPadding: genderRadioDelegate.indicator.width + genderRadioDelegate.spacing
                text: modelData
                opacity: enabled ? 1.0 : 0.3
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
            indicator: Rectangle {
                implicitWidth: 20
                implicitHeight: 20
                //x: genderRadioDelegate.width - width - genderRadioDelegate.leftPadding
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
                    color: genderRadioDelegate.down ? Universal.background : Universal.foreground
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
