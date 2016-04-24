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

#include <QQmlApplicationEngine>
#include <QtGui/QGuiApplication>
#include <QFont>

#include "controllerattached.h"
#include "controllermanager.h"
#include "pluginsmodel.h"

static FILE *logFile;

static void logMessageHandler(
    QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QByteArray localMsg = msg.toLocal8Bit();

    if (!logFile) {
        return;
    }

    switch (type) {
    case QtDebugMsg:
        fprintf(logFile, "D/[%s@%s:%u] %s\n",
            context.function, context.file, context.line, localMsg.constData());
        break;
    case QtWarningMsg:
        fprintf(logFile, "W/[%s@%s:%u] %s\n",
            context.function, context.file, context.line, localMsg.constData());
        break;
    case QtCriticalMsg:
        fprintf(logFile, "C/[%s@%s:%u] %s\n",
            context.function, context.file, context.line, localMsg.constData());
        break;
    case QtFatalMsg:
        fprintf(logFile, "F/[%s@%s:%u] %s\n",
            context.function, context.file, context.line, localMsg.constData());
        break;
    }

    fflush(logFile);
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Start logging
    logFile = fopen("/tmp/kappashell.log", "w");
    qInstallMessageHandler(logMessageHandler);
    qWarning() << "Starting KappaShell.";

    // Move the mouse cursor off the screen so that it doesn't show on top
    // of the GUI.
    QCursor().setPos(0xFFFF, 0xFFFF);

    // Steam Link only has the Noto font family. Set it as the default font.
    app.setFont(QFont("Noto Sans"));

    // Setup controller input
    CControllerManager controllerManager(&app);
    app.installEventFilter(&controllerManager);
    ControllerAttached::initialize();

    qmlRegisterType<PluginsModel>(
        "org.e7m.kappa.core.private", 1, 0, "PluginsModel");

    QQmlApplicationEngine engine;
    engine.addImportPath("/mnt/disk/kappa/plugins");
    engine.load("qml/KappaShell/main.qml");

    return app.exec();
}
