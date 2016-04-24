TEMPLATE = lib
TARGET = org-e7m-kappa-core-ui
QT += qml quick
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = org.e7m.kappa.core

# Input
SOURCES += \
    plugin.cpp

HEADERS += \
    plugin.h

OTHER_FILES = qmldir \
    SLListView.qml \
    ControllerRepeat.qml \
    SLRoundedPanel.qml \
    ui.qmltypes \
    kappa.json \
    KSHomeMenu.qml \
    KSHomeMain.qml

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = $$OTHER_FILES

unix {
    installPath = /kappa/plugins/org/e7m/kappa/core/ui
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

