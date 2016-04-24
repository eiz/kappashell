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
        qDebug() << "derp derp" << _namespaceName;
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
