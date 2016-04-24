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

#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

#include "plugininfo.h"

PluginInfo::PluginInfo(const QString& path, QObject *parent) :
    QObject(parent)
{
    QFile file(path);

    file.open(QFile::ReadOnly);

    QJsonObject info = QJsonDocument::fromJson(file.readAll()).object();
    QJsonValue jName = info["name"];
    QJsonValue jUi = info["ui"];
    QJsonValue jNamespace = info["namespace"];
    QJsonValue jVersion = info["version"];

    if (jNamespace.isString()) {
        _namespaceName = jNamespace.toString();
    }

    if (jVersion.isString()) {
        _version = jVersion.toString();
    }

    if (jName.isString()) {
        _name = jName.toString();
    }

    if (jUi.isObject()) {
        QJsonObject jUiObj = jUi.toObject();
        QJsonValue jUiSidebar = jUiObj["sidebar"];
        QJsonValue jUiHome = jUiObj["home"];

        if (jUiSidebar.isString()) {
            _sidebarName = jUiSidebar.toString();
        }

        if (jUiHome.isString()) {
            _homeName = jUiHome.toString();
        }
    }
}
