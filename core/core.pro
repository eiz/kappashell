CONFIG += marvell
CONFIG += debug

QMAKE_CXXFLAGS += -Wno-unused-parameter
QMAKE_LFLAGS += '-Wl,-rpath,\'/home/steam/lib\''
LIBS += -lSDL2

# Add more folders to ship with the application, here
folder_01.source = qml/KappaShell
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    controllerattached.cpp \
    controllermanager.cpp \
    pluginsmodel.cpp \
    plugininfo.cpp

target.path = /steamlink/apps/kappashell

marvell {
	INCLUDEPATH += \
		$(MARVELL_ROOTFS)/usr/include/SDL2 \
}

removesteamlink.commands = $(RM) -r steamlink
distclean.depends = removesteamlink
QMAKE_EXTRA_TARGETS += distclean removesteamlink

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    controllerattached.h \
    controllermanager.h \
    pluginsmodel.h \
    plugininfo.h
