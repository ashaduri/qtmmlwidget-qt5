include(../common.pri)
INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD
QT += xml

qtmmlwidget-uselib:!qtmmlwidget-buildlib {
    LIBS += -L$$QTMMLWIDGET_LIBDIR -l$$QTMMLWIDGET_LIBNAME
} else {
    SOURCES += $$PWD/qtmmlwidget.cpp
    HEADERS += $$PWD/qtmmlwidget.h
}

win32 {
    contains(TEMPLATE, lib):contains(CONFIG, shared):DEFINES += QT_QTMMLWIDGET_EXPORT
    else:qtmmlwidget-uselib:DEFINES += QT_QTMMLWIDGET_IMPORT
}
