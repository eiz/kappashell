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
            if (loader.sourceComponent) {
                loader.sourceComponent.destroy();
            }

            if (!plugin) {
                loader.sourceComponent = null;
            }

            var qmlString =
                "import QtQuick 2.0;" +
                "import " + plugin.namespaceName + " " + plugin.version +
                " as Plugin;Component{Plugin." + ui + "{}}";

            loader.sourceComponent =
                Qt.createQmlObject(qmlString, parent, "loadPlugin");
        }
    }

    Rectangle {
        color: "black"
        anchors.fill: parent
    }

    Rectangle {
        id: header
        anchors.left: parent.left
        anchors.right: parent.right
        color: "black"
        height: childrenRect.height + 15

        SLListView {
            id: headerList
            anchors.top: parent.top
            anchors.topMargin: 15
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
                highlight: activeFocus

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
                } else {
                    sidebar.loadPlugin(null);
                }

                if (plugin.homeName) {
                    content.loadPlugin(plugin);
                } else {
                    content.loadPlugin(null);
                }
            }

            Controller.onDpadDownPressed: {
                if (sidebar.isHidden()) {
                    content.focus = true;
                } else {
                    sidebar.focus = true;
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

        function isHidden() {
            return state === "HIDDEN";
        }
    }

    FocusScope {
        id: sidebar
        property variant activePlugin
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
            focus: true

            onLoaded: {
                if (item && item.navigateUp) {
                    item.navigateUp.connect(function () {
                        headerList.focus = true;
                    });
                }

                if (item && item.navigateRight) {
                    item.navigateRight.connect(function() {
                        content.focus = true;
                    });
                }

                if (item && item.contentSelected) {
                    item.contentSelected.connect(function(ui) {
                        content.loadPlugin(sidebar.activePlugin, ui);
                    });
                }
            }
        }

        function loadPlugin(plugin, ui) {
            activePlugin = plugin;
            d.loadPlugin(
                plugin, ui || plugin && plugin.sidebarName,
                this, sidebarLoader);

            if (!plugin) {
                hide();
            }
        }

        function show() {
            if (activePlugin) {
                state = "";
            }
        }

        function hide() {
            state = "HIDDEN";
        }

        function isHidden() {
            return state === "HIDDEN";
        }
    }

    FocusScope {
        id: content
        property variant activePlugin
        anchors.left: sidebar.right
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 15

        SLRoundedPanel {
            id: contentPanel
            anchors.fill: parent

            Loader {
                id: contentLoader
                anchors.fill: parent
                focus: true
            }
        }

        function loadPlugin(plugin, ui) {
            activePlugin = plugin;
            d.loadPlugin(
                plugin, ui || (plugin && plugin.homeName), this, contentLoader);
        }
    }

    Controller.onButtonXPressed: {
        if (sidebar.isHidden()) {
            sidebar.show();
        } else {
            sidebar.hide();
        }
    }

    Controller.onButtonYPressed: {
        header.state = header.state === "" ? "HIDDEN" : "";
    }

    Controller.onButtonGuidePressed: Qt.quit()
}
