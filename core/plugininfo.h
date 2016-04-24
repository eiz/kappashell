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

#ifndef PLUGININFO_H
#define PLUGININFO_H

#include <QObject>

class PluginInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name)
    Q_PROPERTY(QString namespaceName READ namespaceName)
    Q_PROPERTY(QString version READ version)
    Q_PROPERTY(QString sidebarName READ sidebarName)
    Q_PROPERTY(QString homeName READ homeName)

public:
    explicit PluginInfo(const QString& path, QObject *parent = 0);
    const QString& name() { return _name; }
    const QString& namespaceName() { return _namespaceName; }
    const QString& version() { return _version; }
    const QString& sidebarName() { return _sidebarName; }
    const QString& homeName() { return _homeName; }

private:
    QString _name;
    QString _namespaceName;
    QString _version;
    QString _sidebarName;
    QString _homeName;
};

#endif // PLUGININFO_H
