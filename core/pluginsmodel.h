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

#ifndef PLUGINSMODEL_H
#define PLUGINSMODEL_H

#include <QAbstractItemModel>

#include "plugininfo.h"

class PluginsModel : public QAbstractItemModel
{
    Q_OBJECT
    Q_ENUMS(Roles)

public:
    enum Roles {
        PluginInfoRole = Qt::UserRole
    };

    explicit PluginsModel(QObject *parent = 0);
    QModelIndex index(int row, int column, const QModelIndex& parent) const;
    QModelIndex parent(const QModelIndex& child) const;
    int rowCount(const QModelIndex& parent) const;
    int columnCount(const QModelIndex& parent) const;
    QVariant data(const QModelIndex& index, int role) const;
    QHash<int, QByteArray> roleNames() const;

private:
    QVector<PluginInfo *> _plugins;
};

#endif // PLUGINSMODEL_H
