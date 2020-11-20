infile(config.pri, SOLUTIONS_LIBRARY, yes): CONFIG += qtmmlwidget-uselib
TEMPLATE += fakelib
QTMMLWIDGET_LIBNAME = $$qtLibraryTarget(QtSolutions_MMLWidget-2.4)
TEMPLATE -= fakelib
QTMMLWIDGET_LIBDIR = $$PWD/lib
unix:qtmmlwidget-uselib:!qtmmlwidget-buildlib:QMAKE_RPATHDIR += $$QTMMLWIDGET_LIBDIR
