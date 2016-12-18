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
            id: yellowRelationHeader
            color: "#00000000"
            border.width: 1
            radius: 1
            anchors.bottom: parent.top
            anchors.bottomMargin: -56
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            border.color: Universal.color(Universal.Yellow)
            RowLayout {
                anchors.fill: parent
                Text {
                    id: relationsLabel

                text: "Relations"
                font.pointSize: 13
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 166
                }
                Rectangle {
                    id: relationHeaderSpacer
                    color: "#bdbebf"
                    Layout.fillHeight: true
                    Layout.maximumWidth: 1
                    Layout.minimumWidth: 1

                }
                Text {
                    id: candidatesLabel

                text: "Candidates"
                font.pointSize: 13
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 166
            }
            }
        }
    }

    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 55
        spacing: 0

        ListView {
            id: relationList
            clip: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 166
            Layout.preferredWidth: 166
            interactive: true

        }

        Rectangle {
            id: relationListSpacer
            color: "#bdbebf"
            Layout.fillHeight: true
            Layout.maximumWidth: 1
            Layout.minimumWidth: 1

        }
        ListView {
            id: relationCandidateList
            clip: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 166
            Layout.preferredWidth: 166
        }
    }
}
