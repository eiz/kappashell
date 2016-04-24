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
import org.e7m.kappa.core.ui 1.0
import org.e7m.kappa.core.private 1.0

Window {
    visible: true
    visibility: Window.FullScreen

    QtObject {
        id: d

        function loadPlugin(plugin, ui, parent, loader) {
            var qmlString =
                "import QtQuick 2.0;" +
                "import " + plugin.namespaceName + " " + plugin.version +
                " as Plugin;Component{Plugin." + plugin[ui + "Name"] + "{}}";

            if (loader.sourceComponent) {
                loader.sourceComponent.destroy();
            }

            loader.sourceComponent =
                Qt.createQmlObject(qmlString, parent, "loadPlugin");
        }
    }

    Rectangle {
        color: "#101020"
        anchors.fill: parent
    }

    Rectangle {
        id: header
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#181830"
        height: childrenRect.height + 60

        SLListView {
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 15
            height: contentItem.childrenRect.height
            orientation: ListView.Horizontal
            spacing: 20
            focus: true

            model: PluginsModel {}

            delegate: SLRoundedPanel {
                property variant modelData: plugin
                id: wrapper
                height: childrenRect.height
                width: 200
                Text {
                    text: name; font.pointSize: 24;
                    anchors.left: parent.left; anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter
                    color: wrapper.ListView.isCurrentItem ? "cyan" : "white"
                }
            }

            Controller.onButtonAPressed: {
                if (!currentItem) {
                    return;
                }

                var plugin = currentItem.modelData;

                if (!plugin.namespaceName || !plugin.version) {
                    console.log("Can't load invalid plugin.");
                    return;
                }

                if (plugin.sidebarName) {
                    sidebar.loadPlugin(plugin);
                }

                if (plugin.homeName) {
                    content.loadPlugin(plugin);
                }
            }
        }

        states: State {
            name: "HIDDEN"
            PropertyChanges { target: header; y: -header.height }
        }

        Behavior on y {
            NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
        }
    }

    Item {
        id: sidebar
        anchors.top: header.bottom
        anchors.topMargin: 15
        anchors.bottom: parent.bottom
        x: 15
        width: 200

        states: State {
            name: "HIDDEN"
            PropertyChanges { target: sidebar; x: -200 }
        }

        Behavior on x {
            NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
        }

        Loader {
            id: sidebarLoader
            anchors.fill: parent
        }

        function loadPlugin(plugin) {
            d.loadPlugin(plugin, "sidebar", this, sidebarLoader);
        }
    }

    SLRoundedPanel {
        id: content
        anchors.left: sidebar.right
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 15

        Loader {
            id: contentLoader
            anchors.fill: parent
        }

        function loadPlugin(plugin) {
            d.loadPlugin(plugin, "home", this, contentLoader);
        }
    }

    Controller.onButtonXPressed: {
        sidebar.state = sidebar.state === "" ? "HIDDEN" : "";
    }

    Controller.onButtonYPressed: {
        header.state = header.state === "" ? "HIDDEN" : "";
    }

    Controller.onButtonGuidePressed: Qt.quit()
}
