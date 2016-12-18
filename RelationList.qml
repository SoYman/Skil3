import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Layouts 1.1

Item {
    id: relationListView

    property alias relationList: relationList
    property alias relationCandidateList: relationCandidateList
    Rectangle {
        anchors.fill: parent
        border.color: Universal.color(Universal.Yellow)
        border.width: 1

        Rectangle {
            id: rectangle1
            color: "#00000000"
            border.width: 4
            radius: 5
            anchors.bottom: parent.top
            anchors.bottomMargin: -56
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            border.color: Universal.color(Universal.Yellow)

            TextField {
                id: textField1
                text: qsTr("Text Field")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 123
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8
            }

            Text {
                x: 140
                y: 16

                text: "Relations"
                font.pointSize: 13
                anchors.bottom: parent.top
                anchors.bottomMargin: -48
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.right: parent.left
                anchors.rightMargin: -117
                anchors.left: parent.left
                anchors.leftMargin: 8
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 55
        spacing: 0

        ListView {
            id: relationList
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 166
            Layout.preferredWidth: 166
            interactive: true
        }

        Rectangle {
            color: Universal.foreground
            Layout.fillHeight: true
            Layout.maximumWidth: 1
            Layout.minimumWidth: 1

        }
        ListView {
            id: relationCandidateList
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 166
            Layout.preferredWidth: 166
        }
    }
}
