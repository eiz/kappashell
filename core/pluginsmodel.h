#ifndef PLUGINSMODEL_H
#define PLUGINSMODEL_H

#include <QAbstractItemModel>

#include "plugininfo.h"

class PluginsModel : public QAbstractItemModel
{
    Q_OBJECT

public:
    explicit PluginsModel(QObject *parent = 0);
    QModelIndex index(int row, int column, const QModelIndex &parent) const;
    QModelIndex parent(const QModelIndex &child) const;
    int rowCount(const QModelIndex &parent) const;
    int columnCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

private:
    QVector<PluginInfo *> _plugins;
};

#endif // PLUGINSMODEL_H
