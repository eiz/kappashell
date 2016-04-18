// KappaShell
// Copyright (C) 2016 Mackenzie Straight
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with KappaShell.  If not, see <http://www.gnu.org/licenses/>.

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
            anchors.leftMargin: 30
            font.pointSize: 24
            text: "KappaShell"
            color: "white"
        }
    }

    SLListView {
        id: sidebar
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

        delegate: SLRoundedPanel {
            id: wrapper
            width: 200
            height: 30
            highlight: ListView.isCurrentItem

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

    SLRoundedPanel {
        anchors.left: sidebar.right
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 30
    }

    Controller.onButtonGuidePressed: Qt.quit()
}
