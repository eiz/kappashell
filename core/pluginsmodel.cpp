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

#include <QtCore>
#include "pluginsmodel.h"

PluginsModel::PluginsModel(QObject *parent) : QAbstractItemModel(parent)
{
    QDirIterator it("/mnt/disk/kappa/plugins",
        QDirIterator::Subdirectories | QDirIterator::FollowSymlinks);

    while (it.hasNext()) {
        it.next();

        if (it.fileName() == "kappa.json") {
            _plugins.push_back(new PluginInfo(it.filePath(), this));
        }
    }
}

QModelIndex PluginsModel::index(
    int row, int column, const QModelIndex& parent) const
{
    if (row < _plugins.size() && column == 0) {
        return createIndex(row, column, _plugins[row]);
    }

    return QModelIndex();
}

QModelIndex PluginsModel::parent(const QModelIndex& child) const
{
    Q_UNUSED(child);
    return QModelIndex();
}

int PluginsModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent);
    return _plugins.size();
}

int PluginsModel::columnCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent);
    return 1;
}

QVariant PluginsModel::data(const QModelIndex& index, int role) const
{
    if (index.row() < 0 || index.row() >= _plugins.size()) {
        return QVariant();
    }

    if (role == Qt::DisplayRole) {
        PluginInfo *info = (PluginInfo *)index.internalPointer();

        return info->name();
    } else if (role == PluginInfoRole) {
        return QVariant::fromValue((PluginInfo *)index.internalPointer());
    }

    return QVariant();
}

QHash<int, QByteArray> PluginsModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[Qt::DisplayRole] = "name";
    roles[PluginInfoRole] = "plugin";

    return roles;
}
