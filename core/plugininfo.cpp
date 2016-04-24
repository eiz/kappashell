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

    if (jName.isString()) {
        _name = jName.toString();
    }
}
