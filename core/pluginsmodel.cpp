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
