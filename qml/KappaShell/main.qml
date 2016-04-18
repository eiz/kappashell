import QtQuick 2.0
import QtQuick.Window 2.2
import org.e7m.steamlink 1.0

Window {
    visible: true
    visibility: Window.FullScreen

    Rectangle {
        color: "#101020"
        anchors.fill: parent
    }

    Rectangle {
        id: header
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#202040"
        height: childrenRect.height + 60

        Text {
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 70
            font.pointSize: 24
            text: "KappaShell"
            color: "white"
        }
    }

    SLListView {
        focus: true
        anchors.top: header.bottom
        anchors.topMargin: 30
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 30
        width: 200
        spacing: 5
        keyNavigationWraps: true

        model: ListModel {
            ListElement { name: "Following" }
            ListElement { name: "Games" }
            ListElement { name: "Channels" }
            ListElement { name: "Settings" }
        }

        delegate: Item {
            id: wrapper
            width: 200
            height: 30

            Rectangle {
                anchors.fill: parent
                opacity: wrapper.ListView.isCurrentItem ? 0.5 : 0.1
                radius: 5
                color: "#888888"

                Behavior on opacity {
                    NumberAnimation { duration: 100 }
                }
            }

            Text {
                anchors.fill: parent
                id: label
                text: name
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: wrapper.ListView.isCurrentItem ? "cyan" : "white"

                Behavior on color {
                    ColorAnimation { duration: 100 }
                }
            }
        }
    }

    Controller.onButtonGuidePressed: Qt.quit()
}
