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
